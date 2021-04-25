import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar(calendarController: _controller),
        ],
      ),
    );
  }
}
