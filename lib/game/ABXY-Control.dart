import 'package:flutter/material.dart';

class GameABXYControls extends StatefulWidget {

  final void Function(String action) onActionPressed;

  const GameABXYControls({super.key, required this.onActionPressed});

  @override
  State<GameABXYControls> createState() => _GameABXYControlsState();

}

class _GameABXYControlsState extends State<GameABXYControls> {

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
    print('Hai premuto: $action');
    widget.onActionPressed(action);
  }


}