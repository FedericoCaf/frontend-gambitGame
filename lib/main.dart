import 'dart:ffi';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:frontend/game/GameBaseControls.dart';
import 'package:frontend/game/GameInitLoadingScreen.dart';
import 'package:frontend/game/gambit_game.dart';

void main() {
  runApp(GameWidget(
    game: GambitGame(),
    initialActiveOverlays: const ['PauseMenu', 'Controls'],
    loadingBuilder: (BuildContext ctx) {
      return const Gameinitloadingscreen();
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
                height: 35
            ),
          )
        );
      },
      'Controls': (context, game) => Gamebasecontrols
        (onDirectionPressed: (dir) => (game as GambitGame).onDirectionPressed(dir)),
    }
  ));
}

