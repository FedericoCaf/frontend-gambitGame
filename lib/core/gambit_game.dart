import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:gambit_game/components/orc_component.dart';
import 'package:gambit_game/components/hero_component.dart';
import 'package:gambit_game/main.dart';
import 'package:gambit_game/utils/colors.dart';
import 'package:gambit_game/utils/logger.dart';
import 'package:gambit_game/config/game_constants.dart';

/// Main game class for Gambit Game
class GambitGame extends FlameGame with PanDetector, HasCollisionDetection {
  late HeroComponent hero;
  late OrcComponent orc;
  late Sprite background;

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

    background = await loadSprite('background.jpg');

    // Initialize hero with configured size
    hero = HeroComponent(
      size: Vector2(
        SpriteConstants.heroTextureWidth * SpriteConstants.heroScale,
        SpriteConstants.heroTextureHeight * SpriteConstants.heroScale,
      ),
    );
    add(hero);
    gameLogger.gameEvent('Hero initialized');

    // Initialize enemy
    orc = OrcComponent(
      size: Vector2.all(SpriteConstants.orcSize),
      position: Vector2(650, 300),
    );
    add(orc);
    gameLogger.gameEvent('Enemy initialized');

    // Camera settings
    camera.follow(hero, maxSpeed: MovementConstants.cameraMaxSpeed);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    hero.move(info.delta.global);
  }

  @override
  void render(Canvas canvas) {
    // Dimensione del canvas
    final gameSize = size;
    
    // Dimensioni dell'immagine di sfondo
    final bgSize = background.srcSize;
    
    // Calcola il fattore di scala per coprire l'intero canvas
    final scaleX = gameSize.x / bgSize.x;
    final scaleY = gameSize.y / bgSize.y;
    
    // Usa il fattore di scala maggiore per evitare spazi vuoti
    final scale = scaleX > scaleY ? scaleX : scaleY;
    
    // Calcola la nuova dimensione dell'immagine di sfondo
    final sizeToRender = Vector2(bgSize.x * scale, bgSize.y * scale);

    // Calcola la posizione per centrare l'immagine di sfondo
    final positionX = (gameSize.x - sizeToRender.x) / 2;
    final positionY = (gameSize.y - sizeToRender.y) / 2;
    
    background.render(
      canvas,
      size: sizeToRender,
      position: Vector2(positionX, positionY),
    );


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


