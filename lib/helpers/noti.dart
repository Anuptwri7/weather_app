import 'package:assessment/const/StringConst.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Notific {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
    new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings =
    new InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static void scheduleCustomNotification({
    required FlutterLocalNotificationsPlugin fln,
    required DateTime reminderTime,

  }) async {
    // Initialize time zones
    tz.initializeTimeZones();
    tz.initializeTimeZones();

    // Ensure that the time zone is properly set before accessing tz.local
     tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));

    final tz.TZDateTime scheduledDate =
    tz.TZDateTime.from(reminderTime, tz.local);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'Local Notification',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the custom notification
    await fln.zonedSchedule(
      0, // Unique ID for the notification
      StringConst.title,
      StringConst.body,
      scheduledDate,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
