

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

class LocalNotificationService {
  LocalNotificationService();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
   final AndroidInitializationSettings initializationSettingsAndroid =
   const AndroidInitializationSettings('@mipmap/ic_launcher');
  Future<void> init() async {
    // Initialize native android notification

    await flutterLocalNotificationsPlugin.initialize(
       InitializationSettings(
        android: initializationSettingsAndroid,
      ),
    );

  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      visibility: NotificationVisibility.public,
      color:Color(0xFFFFF59D), // Change notification color here
      autoCancel: false,
      showProgress: true,
      silent: true,
      ticker: 'ticker',
    );

    int notificationId = 1;
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      value,
      notificationDetails,
      payload: 'Not present',
    );
  }
  void sendDownloadNotification(String filePath,String fileName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'download_channel_id',
      'Download Channel',

      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      // Specify the small icon resource here
      showProgress: true,
      // Show download progress
      maxProgress: 100,
      // Max progress value
      indeterminate: false, // Make the progress bar determinate
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show initial download notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Download in progress',
      '$fileName file is downloading...',
      platformChannelSpecifics,
      payload: filePath,
    );
  }

  void sendDownloadCompleteNotification(String filePath,String fileName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'download_channel_id',
      'Download Channel',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Cancel the ongoing download notification
    await flutterLocalNotificationsPlugin.cancel(0);

    // Show download complete notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      '$fileName has been downloaded',
      platformChannelSpecifics,
      payload: filePath,
    );
  }
  cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}