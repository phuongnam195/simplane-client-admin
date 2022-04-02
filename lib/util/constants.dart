import 'dart:ui';

class AppColor {
  static const Color primary = Color(0xFFC7F4C2);
  static const Color secondary = Color(0xFFBFB5FF);
  static const Color background = Color(0xFFFDFBF7);
  static const Color titleText = Color(0xFF14171F);
  static const Color descriptionText = Color(0xFF747780);
}

class AppStyle {
  static TextStyle title = TextStyle(
    fontSize: 19,
    color: AppColor.titleText,
    fontWeight: FontWeight.bold,
  );
}
