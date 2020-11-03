import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:translator/database/sqlite_database.dart';
import 'package:translator/preferences/shared_preferences.dart';

class PushNotifications {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messagesController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get messages => _messagesController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('Firebase Token: $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        dynamic id;
        id = message['data']['id'] ?? 'no-data';
        dynamic english;
        english = message['data']['english'] ?? 'no-data';
        dynamic spanish;
        spanish = message['data']['spanish'] ?? 'no-data';

        List data = [id, english, spanish];

        final lang =
            Languages(id: int.tryParse(id), english: english, spanish: spanish);

        SQLiteDatabase.db.insertLanguagesByRaw(lang);
        SharedPref().saveFirebaseData(english);

        _messagesController.sink.add(data);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        dynamic id;
        id = message['data']['id'] ?? 'no-data';
        dynamic english;
        english = message['data']['english'] ?? 'no-data';
        dynamic spanish;
        spanish = message['data']['spanish'] ?? 'no-data';

        List data = [id, english, spanish];

        final lang =
            Languages(id: int.tryParse(id), english: english, spanish: spanish);

        SQLiteDatabase.db.insertLanguagesByRaw(lang);
        SharedPref().saveFirebaseData(english);

        _messagesController.sink.add(data);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

        dynamic id;
        id = message['data']['id'] ?? 'no-data';
        dynamic english;
        english = message['data']['english'] ?? 'no-data';
        dynamic spanish;
        spanish = message['data']['spanish'] ?? 'no-data';

        List data = [id, english, spanish];

        final lang =
            Languages(id: int.tryParse(id), english: english, spanish: spanish);

        SQLiteDatabase.db.insertLanguagesByRaw(lang);
        SharedPref().saveFirebaseData(english);

        _messagesController.sink.add(data);
      },
    );
  }

  dispose() {
    _messagesController?.close();
  }
}
