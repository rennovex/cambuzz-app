import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);

  Future initialise() async {
    _fcm.getToken().then((value) => print(value));

    _fcm.getInitialMessage();

    //foreground
    FirebaseMessaging.onMessage.listen((message) {});
  }
}
