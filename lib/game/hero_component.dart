import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:frontend/game/gambit_game.dart';

class HeroComponent extends SpriteAnimationComponent
    with DragCallbacks, CollisionCallbacks, HasGameReference<GambitGame>{

  Vector2? _previousPosition;

  HeroComponent({
    SpriteAnimation? super.animation,
    super.position,
    Vector2? size,
  }) : super(
    size: size ?? Vector2.all(96),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    
    animation = await game.loadSpriteAnimation(
    'hero_idle.png',
    SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.2,
        textureSize: Vector2(96, 84),
      loop: true,
    ));
    
    position = game.size / 2;

    // Aggiungo un hitbox per le collisioni
    final hitbox = RectangleHitbox.relative(
        Vector2(0.5, 0.5),
        parentSize: size,
        position: Vector2(size.x * 0.25, size.y * 0.25));

    hitbox.debugMode = true; // Abilita la modalità di debug per vedere l'hitbox

    add(hitbox);

  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    position = canvasSize / 2;
  }

  // Quando inizi a trascinare

  // Mentre trascini il dito
  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position += event.canvasDelta; // aggiorna la posizione in base al movimento del dito
  }

  void move(Vector2 delta) {
    _previousPosition = position.clone();
    position.add(delta);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

    // Gestisci la collisione (ad esempio, fermare il movimento)
    // Qui puoi aggiungere logica per cosa succede quando collide con un altro oggetto
    if (_previousPosition != null) {
      position.setFrom(_previousPosition!);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
  }

  // ================== Gravity Simulation ==================

  double velocityY = 0.0; // Velocità verticale
  final double gravity = 500.0; // Forza di gravità
  double jump = -300.0; // Forza del salto
  int ground = 550; // Livello del terreno
  bool isOnGround = false; // Stato di contatto con il terreno

  @override
  void update(double dt) {
    super.update(dt);

    // Calcolo l'accelerazione gravitazionale
    velocityY += gravity * dt;

    // Aggiorno la posizione
    y = y + (velocityY * dt);

    // Gestisco la collisione con il terreno
    if (y + height > ground) {
      y = ground - height;
      velocityY = 0;
      isOnGround = true;
    } else {
      isOnGround = false;
    }

  }

  void jumpAction() {
    if (isOnGround) {
      velocityY = jump as double;
      isOnGround = false;
    }
  }

}
