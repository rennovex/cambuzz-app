import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings _initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    _notificationsPlugin.initialize(_initializationSettings);
  }

  static void display({RemoteMessage message}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        'rennovex.cambuzz',
        'rennovex.cambuzz channel',
        'This is the default Notifications channel',
        importance: Importance.max,
        priority: Priority.max,
      ));

      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }
}
