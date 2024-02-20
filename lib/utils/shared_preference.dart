import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static SharedPreferences? sharedPreference;

  static Future<void> init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static saveString({required String key, required String data}) async {
    if (sharedPreference == null) await init();
    await sharedPreference!.setString(key, data);
  }

  static Future<String> getString({required String key}) async {
    if (sharedPreference == null) await init();
    return sharedPreference!.getString(key) ?? '';
  }

  static saveStringList({required String key, required List<String> data}) async {
    if (sharedPreference == null) await init();
    await sharedPreference!.setStringList(key, data);
  }

  static Future<List<String>> getStringList({required String key}) async {
    if (sharedPreference == null) await init();
    return sharedPreference!.getStringList(key) ?? [];
  }

  static Future<Set<String>> getKeys() async {
    if (sharedPreference == null) await init();
    return sharedPreference!.getKeys();
  }
}
