import 'package:flutter/material.dart'
    show BuildContext, Color, Colors, ScaffoldMessenger, SnackBar, Text;

class AppColors {
  static Color modelColor1 = Colors.blue;
  static Color modelColor2 = const Color.fromARGB(255, 156, 196, 158);
  static Color modelColor3 = const Color.fromARGB(255, 105, 231, 109);
  static Color modelwhite = Colors.white;
  static Color modelblack = Colors.black;
}

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
