import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplane_client_admin/model/user.dart';

class Setting {
  static final Setting _instance = Setting._internal();
  factory Setting() {
    return _instance;
  }
  Setting._internal();

  final _sessionUser = 'SessionUser';
  final _languageCode = 'LanguageCode';

  Future saveUserInfo(User user) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString(_sessionUser, jsonEncode(user.toJson()));
  }

  Future<User?> getUserInfo() async {
    final _prefs = await SharedPreferences.getInstance();
    final json = _prefs.getString(_sessionUser);
    if (json != null) {
      return User.fromJson(jsonDecode(json));
    }
    return null;
  }

  clearAllData() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  Future<String> getLanguage() async {
    final _prefs = await SharedPreferences.getInstance();
    String? languageCode = _prefs.getString(_languageCode);
    if (languageCode == null) {
      languageCode = 'en';
      setLanguage(languageCode);
    }
    return languageCode;
  }

  Future setLanguage(String language) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString(_languageCode, language);
  }
}
