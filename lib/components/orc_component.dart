import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gambit_game/components/hero_component.dart';
import 'package:gambit_game/config/game_constants.dart';
import 'package:gambit_game/core/gambit_game.dart';
import 'package:gambit_game/utils/logger.dart';

enum GoblinState { idle, hurt }

/// Enemy goblin component with collision detection
class OrcComponent extends SpriteAnimationGroupComponent<GoblinState>
    with CollisionCallbacks, HasGameReference<GambitGame> {

  late SpriteAnimation idleAnimation;
  late SpriteAnimation hurtAnimation;

  OrcComponent({
    Vector2? position,
    Vector2? size,
  }) : super(
          size: size ?? Vector2.all(SpriteConstants.goblinTextureWidth),
          anchor: Anchor.center,
          current: GoblinState.idle,
        );

  @override
  FutureOr<void> onLoad() async {
    priority = 100;

    final textureSize = Vector2(
      SpriteConstants.goblinTextureWidth,
      SpriteConstants.goblinTextureHeight,
    );

    idleAnimation = await game.loadSpriteAnimation(
      'goblin/goblin_idle.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: AnimationConstants.idleStepTime,
        textureSize: textureSize,
        loop: true,
      ),
    );

    hurtAnimation = await game.loadSpriteAnimation(
      'goblin/goblin_hurt.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: AnimationConstants.hurtStepTime,
        textureSize: textureSize,
        loop: false,
      ),
    );

    animations = {
      GoblinState.idle: idleAnimation,
      GoblinState.hurt: hurtAnimation,
    };

    // Add hitbox for collisions
    final hitbox = RectangleHitbox.relative(
      Vector2(SpriteConstants.goblinHitboxSize,
          SpriteConstants.goblinHitboxSize,
      ),
      parentSize: Vector2(
          size.x * .7,
          size.y * 1.2,
      ),
      position: Vector2(
          size.x * (1 - SpriteConstants.goblinHitboxSize) - 30,
          size.y * (1 - SpriteConstants.goblinHitboxSize) - 30,
      ),
    );

    hitbox.debugMode = GameSettings.debugHitboxes;

    add(hitbox);

    position = Vector2(700, 335);

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
