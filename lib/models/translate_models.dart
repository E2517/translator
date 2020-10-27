import 'package:flutter/foundation.dart';
import 'package:translator/firebase/push_notifications_firebase.dart';
import 'package:translator/preferences/shared_preferences.dart';

class TranslateModel extends ChangeNotifier {
  String data;
  
  TranslateModel({
    this.data,
  });

  Future get dataFirebase {
    final _pushNotifications = new PushNotifications();
    _pushNotifications.messages.listen((event) {
      notifyListeners();
    });
    return SharedPref().getFirebaseData('firebase');
  }
}
