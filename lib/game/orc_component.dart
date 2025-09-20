import 'dart:async';

import 'package:flame/components.dart';

class OrcComponent extends SpriteComponent {
  OrcComponent({
    Sprite? super.sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
    position: position ?? Vector2.zero(),
    size: size ?? Vector2.all(96), // grandezza standard
    anchor: Anchor.center,
  );

  @override
  FutureOr<void> onLoad() async {
    sprite = sprite ?? await Sprite.load('orc.png');
  }
}
