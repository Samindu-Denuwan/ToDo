import 'package:flutter/cupertino.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/features/task/pages/view_notification.dart';

class NotificationHelper{
  final WidgetRef ref;

  NotificationHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? selectedNotificationPayload;

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?> ();

  initializeNotifications()async{
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
          onDidReceiveLocalNotification: onDidReceivedLocalNotification
        );

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();

    final AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("bell");
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
           iOS: initializationSettingsIOS,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (data) async{
      if(data != null){
        debugPrint('notification payload:${data.payload!}');
      }
      selectNotificationSubject.add(data.payload);
    });

  }

  void requestIOSPermissions(){
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
      <IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true
    );
  }

  Future<void> _configureLocalTimeZone()async{
    tz.initializeTimeZones();
    const String timeZoneName = 'Asia/Colombo';
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future onDidReceivedLocalNotification(
      int id, String? title, String? body, String? payload
      )async{

    showDialog(
      context: ref.context,
      builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title?? ""),
        content: Text(body?? ""),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
              onPressed: (){
              Navigator.pop(context);
              },
              child: const Text("Close")),
          CupertinoDialogAction(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("View")),
        ],
    ),);

  }


  scheduledNotification(
      int days,
      int hours,
      int minutes,
      int seconds,
      Task task) async{
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id??0,
        task.title,
        task.description,
        tz.TZDateTime.now(tz.local)
            .add(Duration(
            days: days,
            hours: hours,
            minutes: minutes,
            seconds: seconds)),
        const NotificationDetails(
      android: AndroidNotificationDetails(
          '0101010',
          'My To-Do')
    ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, matchDateTimeComponents: DateTimeComponents.time,
    payload: '${task.title}|${task.description}|${task.date}|${task.startTime}|${task.endTime}');

  }

  void _configureSelectNotificationSubject(){
    selectNotificationSubject.stream.listen((String? payload)async {
      var title = payload!.split('|')[0];
      var body = payload!.split('|')[1];
      showDialog(context: ref.context, builder: (BuildContext context) => CleanDialog(
        title: title,
        content: body,
        contentTextAlign: TextAlign.justify,
        backgroundColor: Colors.orange,
        titleTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
        actions: [
          CleanDialogActionButtons(
            actionTitle: 'Close',
            onPressed: () => Navigator.pop(context),
          ),
          CleanDialogActionButtons(
            actionTitle: 'View',
            textColor: const Color(0XFF27ae61),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsPage(
                        payload: payload),));

            },
          ),
        ],
      ),

     );
    });

  }



}