import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:gambit_game/components/orc_component.dart';
import 'package:gambit_game/components/hero_component.dart';
import 'package:gambit_game/main.dart';
import 'package:gambit_game/utils/colors.dart';
import 'package:gambit_game/utils/logger.dart';
import 'package:gambit_game/config/game_constants.dart';
import 'package:gambit_game/components/TileMapComponent.dart';

/// Main game class for Gambit Game
class GambitGame extends FlameGame with PanDetector, HasCollisionDetection {
  // -1 = empty space (transparent)
  final List<List<int>> levelMap = [
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12],
    [12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12],
  ];

  late HeroComponent hero;
  late OrcComponent orc;
  late SpriteSheet tileSpriteSheet;

  GambitGame({required MyWorld super.world, super.camera});

  @override
  Color backgroundColor() => AppColors.beigeLight;

  @override
  bool pauseWhenBackgrounded = GameSettings.pauseWhenBackgrounded;

  @override
  Future<void> onLoad() async {
    // Fake loading for splash screen
    await Future.delayed(
      const Duration(seconds: GameSettings.loadingDuration),
    );
    gameLogger.gameEvent('Game loading');

    // Load and add background tiles
    final backgroundSprite = await loadSprite('background/Sky.png');
    final background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = size
      ..priority = -100;

    world.add(background);

    final tilesImage = await images.load('tiles/Tileset_Outside.png');

    // Load tile map component
    tileSpriteSheet = SpriteSheet(image: tilesImage, srcSize: Vector2(32, 32));

    final tileMap = TileMapComponent(
      spriteSheet: tileSpriteSheet,
      tileData: levelMap,
      tileSize: 32 * SpriteConstants.heroScale,
      position: Vector2(0, -280)
    );

    world.add(tileMap);

    // Initialize hero with configured size
    hero = HeroComponent(
      size: Vector2(
        SpriteConstants.heroTextureWidth * SpriteConstants.heroScale,
        SpriteConstants.heroTextureHeight * SpriteConstants.heroScale,
      ),
        position: Vector2(size.x / 2, size.y  / 2)
    );
    world.add(hero);
    gameLogger.gameEvent('Hero initialized');

    // Initialize enemy
    orc = OrcComponent(
      size: Vector2(
        SpriteConstants.goblinTextureWidth * SpriteConstants.goblinScale,
        SpriteConstants.goblinTextureHeight * SpriteConstants.goblinScale,
      ),
      position: Vector2(0, 300),
    );
    world.add(orc);
    gameLogger.gameEvent('Enemy initialized');

    // Camera settings
    camera.follow(hero, maxSpeed: MovementConstants.cameraMaxSpeed);
    camera.viewfinder.position = Vector2(size.x / 2, size.y  / 2);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    hero.move(info.delta.global);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onRemove() {
    removeAll(children);
    processLifecycleEvents();
    Flame.images.clearCache();
    Flame.assets.clearCache();
  }

  /// Handles directional input from controls
  void onDirectionPressed(String direction) {
    const step = MovementConstants.stepSize;
    Vector2 delta;

    switch (direction) {
      case 'up':
        delta = Vector2.zero();
        hero.jumpAction();
        gameLogger.playerAction('Jump');
        break;
      case 'down':
        delta = Vector2(0, step);
        hero.move(delta);
        break;
      case 'left':
        delta = Vector2(-step, 0);
        hero.move(delta);
        break;
      case 'right':
        delta = Vector2(step, 0);
        hero.move(delta);
        break;
      case 'stop':
        hero.stop();
        break;
      default:
        delta = Vector2.zero();
        hero.move(delta);
    }
  }

  /// Handles action button input (A, B, X, Y)
  void onActionPressed(String action) {
    switch (action) {
      case 'A':
        hero.attack();
        gameLogger.playerAction('Attack');
        break;
      default:
        // Handle other actions if needed
        break;
    }
  }
}
