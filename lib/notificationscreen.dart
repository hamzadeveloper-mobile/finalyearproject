import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class NotificationPage extends StatefulWidget {
  static String id = 'notification_screen';
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: NotificationStream(),
      ),
    );
  }
}

class NotificationStream extends StatefulWidget {
  final String todayDate;
  NotificationStream({this.todayDate});

  @override
  _NotificationStreamState createState() => _NotificationStreamState();
}

class _NotificationStreamState extends State<NotificationStream> {
  FlutterLocalNotificationsPlugin fltrNotification;
  @override
  void initState() {
    super.initState();
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var initilizationsSettings =
        new InitializationSettings(android: androidInitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings);
  }

  //ignore: missing_return
  Future<Function> _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Expilert", "This is my channel",
        importance: Importance.max);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);

    var scheduledTime = DateTime.now().add(Duration(seconds: 1));

    fltrNotification.schedule(1, "Your product has expired!!!", 'View Product',
        scheduledTime, generalNotificationDetails);
  }

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formattedDate = formatter.format(now);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('entereditemsdata').snapshots(),
      // ignore: missing_return

      builder: (context, snapshot) {
        List<NotificationCard> notificationCards = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final items = snapshot.data.docs;

        for (var item in items) {
          final itemData = item.data();
          final productName = itemData['productName'];
          final expiryDate = itemData['expiryDate'];

          final notificationCard = NotificationCard(
            pName: productName,
            eDate: expiryDate,
          );

          if (formattedDate == expiryDate) {
            notificationCards.add(notificationCard);
            _showNotification();
          }
        }

        return Expanded(
          child: ListView(
            children: notificationCards,
          ),
        );
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String pName;
  final String eDate;

  NotificationCard({this.pName, this.eDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(colors: [
            Color(0xffFDDB27),
            Color(0xffFDDB27),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$pName has expired on $eDate",
              style: TextStyle(
                color: Color(0xff00B1D2),
                fontFamily: 'Avenir',
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
