import 'package:flutter/material.dart';

class Gamebasecontrols extends StatelessWidget {

  final void Function(String direction) onDirectionPressed;

  const Gamebasecontrols({super.key, required this.onDirectionPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(Icons.arrow_upward, 'up'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             _buildButton(Icons.arrow_back, 'left'),
              const SizedBox(width: 20),
             _buildButton(Icons.arrow_forward, 'right')
            ],
          ),
          _buildButton(Icons.arrow_downward, 'down'),
        ],
      )
    );
  }

  Widget _buildButton(IconData icon, String direction) {
    return GestureDetector(
      onTapUp: (_) => onDirectionPressed(direction),
      onLongPress: () => onDirectionPressed(direction),
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


}
