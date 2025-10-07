

import 'package:flutter/cupertino.dart';

class LifepointsMenu extends StatefulWidget {

  const LifepointsMenu({super.key});

  @override
  State<LifepointsMenu> createState() => _LifepointsMenuState();

}

class _LifepointsMenuState extends State<LifepointsMenu> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft - const Alignment(- 0.1, -0.1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeart(),
          const SizedBox(height: 2),
          _buildHeart(),
          const SizedBox(height: 2),
          _buildHeart(),
          const SizedBox(height: 2),
          _buildHeart(),
          const SizedBox(height: 2),
          _buildHeart(),
        ],
      ),
    );
  }

  Widget _buildHeart() {
    return const Image(
      image: AssetImage('assets/images/heart.png'),
      width: 32,
      height: 32,
    );
  }

}