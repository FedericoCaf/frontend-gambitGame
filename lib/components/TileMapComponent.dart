import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class TileMapComponent extends PositionComponent {
  final SpriteSheet spriteSheet;
  final List<List<int>> tileData;
  final double tileSize;

  TileMapComponent({
    required this.spriteSheet,
    required this.tileData,
    this.tileSize = 48.0,
    super.position,
  });

  @override
  FutureOr<void> onLoad() {
    for (int row = 0; row < tileData.length; row++) {
      for (int col = 0; col < tileData[row].length; col++) {
        final tileId = tileData[row][col];

        if (tileId >= 0) {
          final tile = SpriteComponent()
              ..sprite = spriteSheet.getSpriteById(tileId)
              .. size = Vector2(tileSize, tileSize)
              .. position = Vector2(col * tileSize, row * tileSize)
              ..priority = - 10;

          add(tile);
        }
      }
    }
  }
}