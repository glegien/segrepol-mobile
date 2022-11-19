import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Init {
  static Future initialize() async {
    await _configureUserId();
  }

  static String? userIdd;

  static _configureUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId;
    if (prefs.getString("userId") == null) {
      userId = "#UX${Random().nextInt(99999)}";
      prefs.setString("userId", userId);
    } else {
      userId = prefs.getString("userId");
    }
    userIdd = userId;
  }
}
