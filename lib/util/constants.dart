import 'dart:ui';

class AppColor {
  static const Color primary = Color(0xFF3C58C9);
  static const Color secondary = Color(0xFF418ED4);
  static const Color background = Color(0xFFFDFBF7);
  static const Color title = Color(0xFF14171F);
  static const Color description = Color(0xFF9D9D9D);
}

class AppStyle {
  static TextStyle title = TextStyle(
    fontSize: 19,
    color: AppColor.title,
    fontWeight: FontWeight.bold,
  );
}
