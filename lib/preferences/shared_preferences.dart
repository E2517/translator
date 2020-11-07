import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  Future saveFirebaseData(value) async => _prefs.setString('token', value);

  Future<String> getFirebaseData(String key) async => _prefs.getString(key);

  Future removeFirebaseData(String key) async => _prefs.remove(key);
}
