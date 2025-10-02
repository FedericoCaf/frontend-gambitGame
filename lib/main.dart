import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gambit_game/widgets/abxy_control.dart';
import 'package:gambit_game/widgets/game_base_controls.dart';
import 'package:gambit_game/screens/game_init_loading_screen.dart';
import 'package:gambit_game/core/gambit_game.dart';
import 'package:gambit_game/utils/logger.dart';

/// Main world component for the game
class MyWorld extends World {
  @override
  Future<void> onLoad() async {
    // World-specific loading logic can be added here
    // Components, properties, etc. can be initialized
    gameLogger.gameEvent('World loaded');
  }
}

void main() {
  // Initialize logger
  gameLogger.gameEvent('Game starting');

  runApp(
    GameWidget(
      game: GambitGame(
        world: MyWorld(),
      ),
      initialActiveOverlays: const ['PauseMenu', 'Controls', 'ActionControls'],
      loadingBuilder: (BuildContext ctx) {
        return const GameInitLoadingScreen();
      },
      overlayBuilderMap: {
        'PauseMenu': (context, game) {
          return Align(
            alignment: Alignment.topRight - const Alignment(0.1, -0.2),
            child: Container(
              color: Colors.transparent,
              child: const Image(
                image: AssetImage('assets/images/pause.png'),
                width: 35,
                height: 35,
              ),
            ),
          );
        },
        'Controls': (context, game) => GameBaseControls(
              onDirectionPressed: (dir) =>
                  (game as GambitGame).onDirectionPressed(dir),
            ),
        'ActionControls': (context, game) => GameAbxyControls(
              onActionPressed: (action) =>
                  (game as GambitGame).onActionPressed(action),
            ),
      },
    ),
  );
}

