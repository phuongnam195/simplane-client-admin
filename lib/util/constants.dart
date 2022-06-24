import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFF3C58C9);
  static const Color secondary = Color(0xFF418ED4);
  static const Color background = Color(0xFFFDFBF7);
  static const Color title = Color(0xFF6E7E97);
  static const Color subtitle = Color(0xFF14171F);
  static const Color description = Color(0xFF9D9D9D);
  static const Color negative = Colors.grey;
}

class AppStyle {
  static TextStyle title = const TextStyle(
    color: AppColor.title,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subtitle = const TextStyle(
    fontSize: 15,
    color: AppColor.subtitle,
    fontWeight: FontWeight.w500,
  );

  static TextStyle heading = const TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  static TextStyle content = const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
}
