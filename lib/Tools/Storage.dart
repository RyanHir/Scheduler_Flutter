import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static read(key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key) ?? 0;
    return value;
  }

  static save(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
}