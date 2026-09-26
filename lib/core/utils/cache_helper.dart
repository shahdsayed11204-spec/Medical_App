import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (prefs == null) {
      await init();
    }

    if (value is String) {
      return prefs!.setString(key, value);
    }

    if (value is int) {
      return prefs!.setInt(key, value);
    }

    if (value is bool) {
      return prefs!.setBool(key, value);
    }

    if (value is double) {
      return prefs!.setDouble(key, value);
    }

    if (value is List<String>) {
      return prefs!.setStringList(key, value);
    }

    return false;
  }

  static dynamic getData({
    required String key,
  }) {
    return prefs?.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    if (prefs == null) {
      await init();
    }

    return prefs!.remove(key);
  }

  static Future<bool> clearData() async {
    if (prefs == null) {
      await init();
    }

    return prefs!.clear();
  }

  static bool containsKey({
    required String key,
  }) {
    return prefs?.containsKey(key) ?? false;
  }
}