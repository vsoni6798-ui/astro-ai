import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// Wraps flutter_local_notifications to schedule a daily horoscope
/// reminder. Call NotificationService.init() once in main() before runApp.
class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz_data.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _plugin.initialize(initSettings);
  }

  /// Schedules a repeating daily notification at [hour]:[minute] local time.
  static Future<void> scheduleDailyReminder({
    int hour = 9,
    int minute = 0,
  }) async {
    await _plugin.zonedSchedule(
      1,
      '✨ Your Horoscope is Ready',
      'Tap to see what the stars have planned for you today.',
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_horoscope',
          'Daily Horoscope',
          channelDescription: 'Daily horoscope reminder notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
