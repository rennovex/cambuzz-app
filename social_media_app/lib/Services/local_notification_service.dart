import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(Function setPage) {
    final InitializationSettings _initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    _notificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: (topic) async {
      if (topic.contains('/topics/newEventAdded')) setPage(3);
    });
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
          message.notification?.body, notificationDetails,
          payload: message.from);
    } on Exception catch (e) {
      print(e);
    }
  }
}
