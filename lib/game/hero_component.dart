import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:frontend/game/gambit_game.dart';


enum HeroState { idle, run, jump, attack }

class HeroComponent extends SpriteAnimationGroupComponent<HeroState>
    with DragCallbacks, CollisionCallbacks, HasGameReference<GambitGame>{

  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation attackAnimation;

  Vector2? _previousPosition;

  HeroComponent({
    super.position,
    Vector2? size,
  }) : super(
    size: size ?? Vector2.all(96),
    anchor: Anchor.center,
    current: HeroState.idle
  );

  @override
  Future<void> onLoad() async {
    
    idleAnimation = await game.loadSpriteAnimation(
    'hero/hero_idle.png',
    SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.2,
        textureSize: Vector2(96, 84),
      loop: true,
    ));

    runAnimation = await game.loadSpriteAnimation(
    'hero/hero_run.png', SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.2,
        textureSize: Vector2(96, 84),
        loop: true,
    ));

    jumpAnimation = await game.loadSpriteAnimation(
    'hero/hero_jump.png', SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.2,
        textureSize: Vector2(96, 84),
        loop: false,
    ));

    attackAnimation = await game.loadSpriteAnimation(
    'hero/hero_attack.png', SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2(96, 84),
        loop: false,
    ));

    animations = {
      HeroState.idle: idleAnimation,
      HeroState.run: runAnimation,
      HeroState.jump: jumpAnimation,
      HeroState.attack: attackAnimation
    };
    
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
    if (delta.x != 0) {
      isMoving = true;
      if (isOnGround) {
        current = HeroState.run;
      }
      // Flipo l'animazione in base alla direzione
      if (delta.x > 0) {
        scale = Vector2(1, 1); // Direzione destra
      } else {
        scale = Vector2(-1, 1); // Direzione sinistra
      }
    } else {
      isMoving = false;
      current = HeroState.idle;
    }
  }

  void attack() {
    if (!isAttacking) {
      current = HeroState.attack;
      isAttacking = true;
      attackTimer = 0.0;
    }
  }

  void stop() {
    isMoving = false;
    if (isOnGround) {
      current = HeroState.idle;
    }
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
    super.onCollisionEnd(other);
  }

  // ================== Gravity Simulation ==================

  double velocityY = 0.0; // Velocità verticale
  final double gravity = 500.0; // Forza di gravità
  double jump = -300.0; // Forza del salto
  int ground = 550; // Livello del terreno
  bool isOnGround = false; // Stato di contatto con il terreno
  bool isMoving = false; // Stato di movimento orizzontale
  double attackDuration = 0.6; // Durata dell'attacco in secondi
  double attackTimer = 0.0; // Timer per l'attacco
  bool isAttacking = false; // Stato di attacco

  void jumpAction() {
    current = HeroState.jump;
    if (isOnGround) {
      velocityY = jump;
      isOnGround = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isAttacking) {
      attackTimer += dt;
      if (attackTimer >= attackDuration) {
        print('Fine Attacco!');
        isAttacking = false;
        current = HeroState.idle;
      }
    }

    // Calcolo l'accelerazione gravitazionale
    velocityY += gravity * dt;

    // Aggiorno la posizione
    y = y + (velocityY * dt);

    // Gestisco la collisione con il terreno
    if (y + height > ground) {
      y = ground - height;
      velocityY = 0;
      isOnGround = true;
      if (current == HeroState.jump) {
        current = isMoving ? HeroState.run : HeroState.idle;
      }
    } else {
      isOnGround = false;
    }

    // forza idle se non ti muovi e sei a terra
    if (!isMoving && isOnGround
        && current != HeroState.jump
        && !isAttacking) {
      current = HeroState.idle;
    }

  }

}
