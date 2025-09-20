import 'package:flutter/material.dart';

class Gameinitloadingscreen extends StatelessWidget {

  const Gameinitloadingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'Caricamento in corso...',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      )
    );
  }




}
