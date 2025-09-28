import 'dart:async';

import 'package:flutter/material.dart';

class Gamebasecontrols extends StatefulWidget {
  final void Function(String direction) onDirectionPressed;

  const Gamebasecontrols({super.key, required this.onDirectionPressed});

  @override
  State<Gamebasecontrols> createState() => _GamebasecontrolsState();
}

class _GamebasecontrolsState extends State<Gamebasecontrols> {
  Timer? _timer;

  void _startMoving(String direction) {
    if (direction == 'up') {
      widget.onDirectionPressed(direction);
    } else {
      widget.onDirectionPressed(direction);
      _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
        widget.onDirectionPressed(direction);
      });
    }
  }

  void _stopMoving() {
    _timer?.cancel();
    _timer = null;
    widget.onDirectionPressed('stop');
  }

  Widget _buildButton(IconData icon, String direction) {
    return GestureDetector(
      onTapDown: (_) => _startMoving(direction),
      onTapUp: (_) => _stopMoving(),
      onTapCancel: _stopMoving,
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

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
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
        ));
  }

  @override
  void dispose() {
    _stopMoving();
    super.dispose();
  }
}
