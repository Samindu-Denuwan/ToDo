import 'package:flutter/cupertino.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

class NotificationHelper{
  final WidgetRef ref;

  NotificationHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? selectedNotificationPayload;

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?> ();

  initializeNotifications()async{
   // _configureSelectNotificationSubject();
    await _configureLocalTimeZone();

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
          onDidReceiveLocalNotification: onDidReceivedLocalNotification
        );
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
    const String timeZoneName = 'Asia/Sri Lanka';
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

        ],
    ),);

  }



}