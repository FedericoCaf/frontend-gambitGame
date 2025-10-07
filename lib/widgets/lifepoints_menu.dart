import 'package:flutter/cupertino.dart';
import 'package:gambit_game/services/hero_stats_service.dart';

class LifepointsMenu extends StatefulWidget {
  const LifepointsMenu({super.key});

  @override
  State<LifepointsMenu> createState() => _LifepointsMenuState();
}

class _LifepointsMenuState extends State<LifepointsMenu> {
  final HeroStatsService statsService = HeroStatsService();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft - const Alignment(-0.1, -0.1),
      child: ListenableBuilder(
        listenable: statsService,
        builder: (BuildContext context, Widget? child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: statsService.currentHearts > 0
                ? List<Widget>.generate(
                    statsService.currentHearts,
                    (index) => _buildHeart(),
                  )
                : [
                    const Text(
                      '💀',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ],
          );
        },
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
