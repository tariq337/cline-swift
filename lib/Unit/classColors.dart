import 'package:flutter/material.dart';

class classColors {
// a p c d f

  static const Color bgColor = Color(0xFF4448FF);

  static List<Color> STATICS(bool mode) {
    if (mode) {
      return const [
        Color(0xFF2196F3), //blue 0
        Color(0xFFF7AD00), //yellow 1
        Color(0xFF4CAF50), //green 2
        Color(0xFFF44336), //red 3
        Color(0xFF555758), //gry 4
      ];
    } else {
      return const [
        Color(0xC32195F3), //blue
        Color(0xCEF7AD00), //yellow
        Color(0xD34CAF4F), //green
        Color(0xC8F44336), //red
        Color(0xBC555758), //gry
      ];
    }
  }

  static List<Color> NEUTRAL(bool mode) {
    if (mode) {
      return const [
        Color(0xFF1F2724), //0
        Color(0xFF727272), //1
        Color(0xFFF0F0F0), //2
        Color(0xFFF5F5F5), //3
        Color(0xFFFFFFFF) //4
      ];
    } else {
      return const [
        Color(0xFFC1F1E1), //0
        Color(0xFF363636), //1
        Color(0xFF1D1F29), //2
        Colors.black54, //3
        Color(0xFF101118) //4
      ];
    }
  }
}
