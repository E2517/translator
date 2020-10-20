import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future saveFirebaseData(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('firebase', value);
  }

  Future<String> getFirebaseData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future removeFirebaseData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
