import 'package:flutter_test/flutter_test.dart';
import 'package:gambit_game/config/game_constants.dart';

void main() {
  group('GameConstants', () {
    test('PhysicsConstants should have valid values', () {
      expect(PhysicsConstants.gravity, greaterThan(0));
      expect(PhysicsConstants.jumpForce, lessThan(0));
      expect(PhysicsConstants.groundLevel, greaterThan(0));
    });

    test('MovementConstants should have valid values', () {
      expect(MovementConstants.stepSize, greaterThan(0));
      expect(MovementConstants.cameraMaxSpeed, greaterThan(0));
    });

    test('AnimationConstants should have valid values', () {
      expect(AnimationConstants.idleStepTime, greaterThan(0));
      expect(AnimationConstants.runStepTime, greaterThan(0));
      expect(AnimationConstants.jumpStepTime, greaterThan(0));
      expect(AnimationConstants.attackStepTime, greaterThan(0));
      expect(AnimationConstants.attackDuration, greaterThan(0));
    });

    test('SpriteConstants should have valid values', () {
      expect(SpriteConstants.heroTextureWidth, greaterThan(0));
      expect(SpriteConstants.heroTextureHeight, greaterThan(0));
      expect(SpriteConstants.heroScale, greaterThan(0));
      expect(SpriteConstants.orcSize, greaterThan(0));
      expect(
        SpriteConstants.heroHitboxSize,
        greaterThan(0),
      );
      expect(SpriteConstants.heroHitboxSize, lessThanOrEqualTo(1));
    });

    test('GameSettings should have valid values', () {
      expect(GameSettings.loadingDuration, greaterThan(0));
      expect(GameSettings.debugHitboxes, isA<bool>());
      expect(GameSettings.pauseWhenBackgrounded, isA<bool>());
    });
  });
}
