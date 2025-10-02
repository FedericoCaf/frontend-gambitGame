import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gambit_game/core/gambit_game.dart';
import 'package:gambit_game/main.dart';

void main() {
  group('GambitGame', () {
    late GambitGame game;

    setUp(() {
      game = GambitGame(world: MyWorld());
    });

    test('game initializes with correct world', () {
      expect(game.world, isA<MyWorld>());
    });

    test('game has collision detection', () {
      expect(game, isA<HasCollisionDetection>());
    });
  });

  group('MyWorld', () {
    test('world can be instantiated', () {
      final world = MyWorld();
      expect(world, isA<World>());
    });
  });
}
