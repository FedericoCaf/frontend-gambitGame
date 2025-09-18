import 'package:flame/components.dart';

class OrcComponent extends SpriteComponent {
  OrcComponent({
    required Sprite sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
    sprite: sprite,
    position: position ?? Vector2.zero(),
    size: size ?? Vector2.all(96), // grandezza standard
    anchor: Anchor.center,
  );
}
