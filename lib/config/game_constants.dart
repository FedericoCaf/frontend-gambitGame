/// Game constants and configuration values
library;

/// Physics constants
class PhysicsConstants {
  PhysicsConstants._();

  /// Gravity force applied to game objects
  static const double gravity = 500.0;

  /// Jump force for hero
  static const double jumpForce = -300.0;

  /// Ground level Y position
  static const double groundLevel = 550.0;
}

/// Movement constants
class MovementConstants {
  MovementConstants._();

  /// Step size for directional movement
  static const double stepSize = 15.0;

  /// Maximum camera follow speed
  static const double cameraMaxSpeed = 250.0;
}

/// Animation constants
class AnimationConstants {
  AnimationConstants._();

  /// Idle animation step time
  static const double idleStepTime = 0.15;

  /// Run animation step time
  static const double runStepTime = 0.1;

  /// Jump animation step time
  static const double jumpStepTime = 0.2;

  /// Attack animation step time
  static const double attackStepTime = 0.05;

  /// Attack duration in seconds
  static const double attackDuration = 0.35;
}

/// Sprite size constants
class SpriteConstants {
  SpriteConstants._();

  /// Hero sprite texture size
  static const double heroTextureWidth = 96.0;
  static const double heroTextureHeight = 84.0;

  /// Hero display scale factor
  static const double heroScale = 3.0;

  /// Orc sprite size
  static const double orcSize = 128.0;

  /// Hero hitbox relative size
  static const double heroHitboxSize = 0.5;
}

/// Game settings
class GameSettings {
  GameSettings._();

  /// Fake loading duration in seconds (for splash screen)
  static const int loadingDuration = 0;

  /// Enable debug mode for hitboxes
  static const bool debugHitboxes = true;

  /// Pause game when backgrounded
  static const bool pauseWhenBackgrounded = true;
}
