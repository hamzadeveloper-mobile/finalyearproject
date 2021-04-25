import 'dart:math';

import 'package:expilert/addScreenButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = FirebaseFirestore.instance;

class ImageItemAddScreen extends StatefulWidget {
  final String expiryValue;
  ImageItemAddScreen({@required this.expiryValue});

  static String id = 'image_item_add_screen';
  @override
  _ImageItemAddScreenState createState() => _ImageItemAddScreenState();
}

class _ImageItemAddScreenState extends State<ImageItemAddScreen> {
  var _formkey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final openingDateController = TextEditingController();
  final expiryDateController = TextEditingController();
  final noOfItemsController = TextEditingController();

  String productName;
  String openingDate;
  String expiryDate;
  String noOfItems;
  String openingValue = 'Not Specified';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  children: [
                    TextLiquidFill(
                      text: 'Image Processed Input',
                      waveColor: Color(0xff00B1D2),
                      boxBackgroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Source Sans Pro',
                      ),
                      boxHeight: 100.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          productName = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter product name',
                        ),
                        textAlign: TextAlign.center,
                        controller: productNameController,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter Product Name";
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          openingDate = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter package opening date (dd/mm/yyyy)',
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.datetime,
                        controller: openingDateController,
                        // ignore: missing_return
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter expiry date (dd/mm/yyyy)',
                        ),
                        onChanged: (value) {
                          expiryDate = value;
                        },
                        initialValue: widget.expiryValue,
                        textAlign: TextAlign.center,
                        // controller: expiryDateController,
                        keyboardType: TextInputType.datetime,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter Expiry Date";
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          noOfItems = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'No. of items',
                        ),
                        textAlign: TextAlign.center,
                        controller: noOfItemsController,
                        keyboardType: TextInputType.number,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter No. of Items";
                          }
                        },
                      ),
                    ),
                    AddScreenButton(
                        title: 'Proceed',
                        onPressed: () {
                          setState(() {
                            if (expiryDate == null) {
                              expiryDate = widget.expiryValue;
                            }
                            if (openingDate == null) {
                              openingDate = openingValue;
                            }
                            if (_formkey.currentState.validate()) {
                              _firestore.collection('entereditemsdata').add({
                                'productName': productName,
                                'openingDate': openingDate,
                                'noOfItems': noOfItems,
                                'expiryDate': expiryDate,
                              });
                              _firestore.collection('expirydates').add({
                                'expirydate': expiryDate,
                              });
                              productNameController.clear();
                              expiryDateController.clear();
                              openingDateController.clear();
                              noOfItemsController.clear();
                              Navigator.pop(context);
                            }
                          });
                        }),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
