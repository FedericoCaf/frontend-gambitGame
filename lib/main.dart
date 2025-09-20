import 'dart:ffi';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:frontend/game/GameInitLoadingScreen.dart';
import 'package:frontend/game/gambit_game.dart';

void main() {
  runApp(GameWidget(
      game: GambitGame(),
      loadingBuilder: (BuildContext ctx) {
        return const Gameinitloadingscreen();
      },
  ));
}
