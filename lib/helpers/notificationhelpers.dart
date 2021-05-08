import 'package:family_report_project/main.dart';
import 'package:family_report_project/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './../models/remindernotification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/subjects.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import '../helpers/sharedpreferenceshelper.dart';

final BehaviorSubject<ReminderNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReminderNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  tz.initializeTimeZones();
  String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReminderNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    var familyId = await SharedPreferencesHelper.getFamilyCollectionName();
    var currentUid = await SharedPreferencesHelper.getFamilyMemberUid();

    try {
      await MyApp.navigationKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            familyId: familyId,
            loggedInUserUid: currentUid,
          ),
        ),
      );
    } catch (e) {
      print(e.toString());
    }

    // selectNotificationSubject.add(payload);
  });
}

Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '0', 'Natalia', 'your channel description',
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'Natalia title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> turnOffNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> turnOffNotificationById(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    num id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> scheduleNotification(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  String id,
) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember about it',
    icon: 'app_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  tz.initializeTimeZones();
  String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}

Future<void> scheduleNotificationPeriodically(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String body,
    RepeatInterval interval) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember about it',
    icon: 'smile_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(
      0, 'Daily Log Reminder', body, interval, platformChannelSpecifics);
}

Future<tz.TZDateTime> _nextInstanceOfReminder(DateTime date) async {
  tz.initializeTimeZones();
  String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  final toBeScheduledTime = tz.TZDateTime.from(date, tz.local);
  print(toBeScheduledTime);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      toBeScheduledTime.year,
      toBeScheduledTime.month,
      toBeScheduledTime.day,
      toBeScheduledTime.hour,
      toBeScheduledTime.minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

Future<void> scheduleDailyNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String body,
    DateTime date) async {
  _nextInstanceOfReminder(date).then((value) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Daily Log Reminder',
        'Hey! It is time for logging your daily observations on the app.',
        value,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  });
}

void requestIOSPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}
