import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gambit_game/config/game_constants.dart';
import 'package:gambit_game/utils/logger.dart';

/// Enemy orc component with collision detection
class OrcComponent extends SpriteComponent with CollisionCallbacks {
  OrcComponent({
    Sprite? super.sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position ?? Vector2.zero(),
          size: size ?? Vector2.all(SpriteConstants.orcSize),
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() async {
    sprite = sprite ?? await Sprite.load('orc.png');
    add(
      RectangleHitbox()..debugMode = GameSettings.debugHitboxes,
    );
    gameLogger.debug('Orc component loaded');
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Handle collision logic
    gameLogger.debug('Orc collision detected');
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // Handle collision end
  }
}
