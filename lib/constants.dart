import 'package:flutter/material.dart';

const kNavBarStyle = TextStyle(
  fontFamily: 'Dosis',
  fontSize: 15.0,
);

const kSelectImageButtonTextStyle = TextStyle(
  fontFamily: 'Dosis',
  fontSize: 18.0,
);

const kItemsCardTextStyling = TextStyle(
  fontSize: 15.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff00B1D2), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffFDDB27), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
