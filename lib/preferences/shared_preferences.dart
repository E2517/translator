import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  saveFirebaseData(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('firebase', value);
  }

  getFirebaseData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  removeFirebaseData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
