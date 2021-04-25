import 'package:flutter/material.dart';

class AddScreenButton extends StatelessWidget {
  AddScreenButton({@required this.title, @required this.onPressed});

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        color: Color(0xff00B1D2),
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          highlightColor: Color(0xffFDDB27),
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xffFDDB27),
            ),
          ),
        ),
      ),
    );
  }
}
