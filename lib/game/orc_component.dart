import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class OrcComponent extends SpriteComponent with CollisionCallbacks {
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
    add(
      RectangleHitbox()..debugMode = true,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

    // Gestisci la collisione (ad esempio, fermare il movimento)
    // Qui puoi aggiungere logica per cosa succede quando collide con un altro oggetto
  }

  @override
  void onCollisionEnd(PositionComponent other) {
  }

}
