import 'package:expilert/futureworkscreen.dart';
import 'package:expilert/notificationscreen.dart';
import 'package:flutter/material.dart';
import 'calender_screen.dart';
import 'itemssceen.dart';
import 'addscreen.dart';
import 'constants.dart';
import 'package:expilert/local_push_notification.dart';

class Nav extends StatefulWidget {
  static String id = 'nav_screen';
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 2;
  List<Widget> _widgetOptions = <Widget>[
    FutureScreen(),
    ItemScreen(),
    AddScreen(),
    NotificationPage(),
    Calender(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'expilert',
            style: TextStyle(
              fontFamily: 'Poiret One',
              color: Color(0xffFDDB27),
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          )),
          backgroundColor: Color(0xff00B1D2),
        ),
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff00B1D2),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xffFDDB27),
          unselectedItemColor: Colors.white,
          iconSize: 30.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.gesture_rounded),
              title: Text(
                'pro',
                style: kNavBarStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_headline_rounded),
              title: Text(
                'items',
                style: kNavBarStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              title: Text(
                'add',
                style: kNavBarStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_rounded),
              title: Text(
                'notifications',
                style: kNavBarStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded),
              title: Text(
                'calender',
                style: kNavBarStyle,
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ));
  }
}
