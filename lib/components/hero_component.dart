import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:gambit_game/core/gambit_game.dart';
import 'package:gambit_game/config/game_constants.dart';
import 'package:gambit_game/utils/logger.dart';

/// Enumeration of hero animation states
enum HeroState { idle, run, jump, attack }

/// Main hero component with animations and physics
class HeroComponent extends SpriteAnimationGroupComponent<HeroState>
    with CollisionCallbacks, HasGameReference<GambitGame> {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation attackAnimation;

  Vector2? _previousPosition;

  HeroComponent({
    Vector2? position,
    Vector2? size,
  }) : super(
          size: size ?? Vector2.all(SpriteConstants.heroTextureWidth),
          anchor: Anchor.center,
          current: HeroState.idle,
        );

  @override
  Future<void> onLoad() async {
    priority = 100;

    final textureSize = Vector2(
      SpriteConstants.heroTextureWidth,
      SpriteConstants.heroTextureHeight,
    );

    idleAnimation = await game.loadSpriteAnimation(
      'hero/hero_idle.png',
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: AnimationConstants.idleStepTime,
        textureSize: textureSize,
        loop: true,
      ),
    );

    runAnimation = await game.loadSpriteAnimation(
      'hero/hero_run.png',
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: AnimationConstants.runStepTime,
        textureSize: textureSize,
        loop: true,
      ),
    );

    jumpAnimation = await game.loadSpriteAnimation(
      'hero/hero_jump.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: AnimationConstants.jumpStepTime,
        textureSize: textureSize,
        loop: false,
      ),
    );

    attackAnimation = await game.loadSpriteAnimation(
      'hero/hero_attack.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: AnimationConstants.attackStepTime,
        textureSize: textureSize,
        loop: false,
      ),
    );

    animations = {
      HeroState.idle: idleAnimation,
      HeroState.run: runAnimation,
      HeroState.jump: jumpAnimation,
      HeroState.attack: attackAnimation,
    };

    position = game.size / 2;

    // Add hitbox for collisions
    final hitbox = RectangleHitbox.relative(
      Vector2(SpriteConstants.heroHitboxSize * 0.5,SpriteConstants.heroHitboxSize),
      parentSize: size,
      position: Vector2(
        size.x * 0.38,
        size.y * 0.25,
      ),
    );

    hitbox.debugMode = GameSettings.debugHitboxes;

    add(hitbox);
    gameLogger.debug('Hero component loaded');
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    position = canvasSize / 2;
  }

  /// Move the hero in a given direction
  void move(Vector2 delta) {
    _previousPosition = position.clone();
    position.add(delta);
    if (delta.x != 0) {
      isMoving = true;
      if (isOnGround) {
        current = HeroState.run;
      }
      // Flip animation based on direction
      if (delta.x > 0) {
        scale = Vector2(1, 1); // Right direction
      } else {
        scale = Vector2(-1, 1); // Left direction
      }
    } else {
      isMoving = false;
      current = HeroState.idle;
    }
  }

  /// Trigger hero attack
  void attack() {
    if (!isAttacking) {
      current = HeroState.attack;
      isAttacking = true;
      attackTimer = 0.0;
    }
  }

  /// Stop hero movement
  void stop() {
    isMoving = false;
    if (isOnGround) {
      current = HeroState.idle;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Handle collision by reverting to previous position
    if (_previousPosition != null) {
      position.setFrom(_previousPosition!);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
  }

  // ================== Physics Properties ==================

  /// Vertical velocity
  double velocityY = 0.0;

  /// Ground contact state
  bool isOnGround = false;

  /// Horizontal movement state
  bool isMoving = false;

  /// Attack timer
  double attackTimer = 0.0;

  /// Attack state
  bool isAttacking = false;

  /// Trigger jump action
  void jumpAction() {
    current = HeroState.jump;
    if (isOnGround) {
      velocityY = PhysicsConstants.jumpForce;
      isOnGround = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Handle attack duration
    if (isAttacking) {
      attackTimer += dt;
      if (attackTimer >= AnimationConstants.attackDuration) {
        gameLogger.debug('Attack finished');
        isAttacking = false;
        current = HeroState.idle;
      }
    }

    // Apply gravity
    velocityY += PhysicsConstants.gravity * dt;

    // Update vertical position
    y = y + (velocityY * dt);

    // Handle ground collision
    if (y + height > PhysicsConstants.groundLevel) {
      y = PhysicsConstants.groundLevel - height;
      velocityY = 0;
      isOnGround = true;
      if (current == HeroState.jump) {
        current = isMoving ? HeroState.run : HeroState.idle;
      }
    } else {
      isOnGround = false;
    }

    // Force idle state when not moving on ground
    if (!isMoving &&
        isOnGround &&
        current != HeroState.jump &&
        !isAttacking) {
      current = HeroState.idle;
    }
  }
}
