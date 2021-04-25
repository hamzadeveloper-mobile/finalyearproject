import 'package:expilert/notificationscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PushNotifications();
  }
}

class PushNotifications extends StatefulWidget {
  @override
  _PushNotificationsState createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var initilizationsSettings =
        new InitializationSettings(android: androidInitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "5555", "This is my channel",
        importance: Importance.max);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);

    var scheduledTime = DateTime.now().add(Duration(seconds: 10));

    fltrNotification.schedule(1, "Your product has expired!!!", 'Task',
        scheduledTime, generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    print('Pressed');
    Navigator.pushNamed(context, NotificationPage.id);
  }
}
