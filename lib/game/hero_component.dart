import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:frontend/game/gambit_game.dart';

class HeroComponent extends SpriteComponent with DragCallbacks, HasGameReference<GambitGame> {

  HeroComponent({
    Sprite? super.sprite,
    super.position,
    Vector2? size,
  }) : super(
    size: size ?? Vector2.all(96),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    sprite = sprite ?? await Sprite.load('viking.png');
    position = game.size / 2;
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
    position.add(delta);
  }

}
