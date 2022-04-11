import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFF3C58C9);
  static const Color secondary = Color(0xFF418ED4);
  static const Color background = Color(0xFFFDFBF7);
  static const Color title = Color(0xFF14171F);
  static const Color subtitle = Color.fromARGB(255, 25, 27, 32);
  static const Color description = Color(0xFF9D9D9D);
}

class AppStyle {
  static TextStyle title = const TextStyle(
    fontSize: 19,
    color: AppColor.title,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subtitle = const TextStyle(
    fontSize: 15,
    color: AppColor.subtitle,
    fontWeight: FontWeight.w600,
  );
}
