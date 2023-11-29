import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  
  static Future init({bool scheduled = false}) async {
    var initAndroidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: initAndroidSettings,
    iOS: ios);
    await _notifications.initialize(settings);
  }

  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
        priority: Priority.max,
        enableVibration: true,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String title,
    String body,
    String payload,
}) async => _notifications.show(
    id,
    title,
    body,
    await _notificationDetails(),
    payload: payload,
  );
}
