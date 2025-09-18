import 'package:flutter/material.dart';

/// Tavolozza di colori personalizzati in formato ARGB (0xAARRGGBB)
class AppColors {
  // Colori primari
  static const Color black   = Color(0xFF000000);
  static const Color white   = Color(0xFFFFFFFF);
  static const Color red     = Color(0xFFFF0000);
  static const Color green   = Color(0xFF00FF00);
  static const Color blue    = Color(0xFF0000FF);

  // Colori secondari
  static const Color yellow  = Color(0xFFFFFF00);
  static const Color cyan    = Color(0xFF00FFFF);
  static const Color magenta = Color(0xFFFF00FF);

  // Varianti di grigio
  static const Color grayLight  = Color(0xFFF5F5F5);
  static const Color gray25  = Color(0xFF404040);
  static const Color gray50  = Color(0xFF808080);
  static const Color gray75  = Color(0xFFBFBFBF);

  // Varianti di beige
  static const Color beigeLight  = Color(0xFFFFF5E1);

  // Trasparenti (alpha < FF)
  static const Color transparent   = Color(0x00000000);
  static const Color semiBlack50   = Color(0x80000000); // nero 50%
  static const Color semiWhite50   = Color(0x80FFFFFF); // bianco 50%
}
