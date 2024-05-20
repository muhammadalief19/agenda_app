import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:agenda_app/model/note_model.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Inisialisasi time zone data
    tz.initializeTimeZones();
  }

  Future<void> scheduleNotification(DateTime dateTime, Note note) async {
    var androidDetails = const AndroidNotificationDetails(
      'ID023134',
      'Es Teler Team',
      channelDescription: 'Agenda App',
      importance: Importance.high,
    );
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      note.id!,
      'Reminder: ${note.name}',
      note.deskripsi,
      tz.TZDateTime.from(dateTime, tz.local),
      generalNotificationDetails,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
