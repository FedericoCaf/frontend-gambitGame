import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/game/orc_component.dart';
import 'package:frontend/main.dart';
import 'package:frontend/utils/colors.dart';
import 'hero_component.dart';

class GambitGame extends FlameGame with PanDetector {
  late HeroComponent hero;
  late OrcComponent orc;
  late Sprite background;

  GambitGame({required MyWorld super.world, super.camera});

  @override
  Color backgroundColor() => AppColors.beigeLight;

  @override
  bool pauseWhenBackgrounded = true;

  @override
  Future<void> onLoad() async {

    //Fake Loading
    await Future.delayed(const Duration(seconds: 3));

    background = await loadSprite('background.jpg');

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
    final positionX = (gameSize.x - sizeToRender.x) / 2 + 70; // Spostamento di 70 pixel a destra
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

  void onDirectionPressed(String direction) {
    const step = 7.0;
    Vector2 delta;

    switch (direction) {
      case 'up':
        delta = Vector2(0, -step);
        break;
      case 'down':
        delta = Vector2(0, step);
        break;
      case 'left':
        delta = Vector2(-step, 0);
        break;
      case 'right':
        delta = Vector2(step, 0);
        break;
      default:
        delta = Vector2.zero();
    }
    hero.move(delta);
  }
}


