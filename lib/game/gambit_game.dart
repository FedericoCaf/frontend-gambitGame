import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/game/orc_component.dart';
import 'package:frontend/utils/colors.dart';
import 'hero_component.dart';

class GambitGame extends FlameGame with PanDetector {
  late HeroComponent hero;
  late OrcComponent orc;

  @override
  Color backgroundColor() => AppColors.beigeLight;

  @override
  Future<void> onLoad() async {

    //Fake Loading
    await Future.delayed(const Duration(seconds: 3));

    // Sprite is now not required (default sprite: viking)
    hero = HeroComponent(
      size: Vector2.all(128),
    );

    add(hero);

    // Sprite is now not required (default enemy sprite: orc)
    orc = OrcComponent(
      size: Vector2.all(128),
      position: size / 2 + Vector2(200, 0),
    );
    add(orc);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    hero.move(info.delta.global);
  }

}


