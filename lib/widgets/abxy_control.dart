import 'package:flutter/material.dart';
import 'package:gambit_game/utils/logger.dart';

/// ABXY action button controls widget
class GameAbxyControls extends StatefulWidget {
  final void Function(String action) onActionPressed;

  const GameAbxyControls({super.key, required this.onActionPressed});

  @override
  State<GameAbxyControls> createState() => _GameAbxyControlsState();
}

class _GameAbxyControlsState extends State<GameAbxyControls> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: _buildButton(Icons.hardware, 'A'),
    );
  }

  Widget _buildButton(IconData icon, String action) {
    return GestureDetector(
      onTapDown: (_) => _startAction(action),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  void _startAction(String action) {
    gameLogger.debug('Action button pressed: $action');
    widget.onActionPressed(action);
  }
}