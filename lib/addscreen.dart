import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'image_processed_item _addscreen.dart';
import 'addScreenButtons.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'manual_item_addscreen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool manualButton = true;
  bool processButton = false;
  File imageFile;
  bool _inProcess = false;
  final picker = ImagePicker();

  _selectImage(BuildContext context, ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    var picture = await picker.getImage(
        source: source, preferredCameraDevice: CameraDevice.rear);
    if (picture != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: picture.path,
          aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 1),
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color(0xff00B1D2),
            toolbarTitle: 'Expilert Image Cropper',
            toolbarWidgetColor: Color(0xffFDDB27),
            backgroundColor: Colors.white,
          ));
      this.setState(() {
        imageFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }

    Navigator.of(context).pop(); //it removes alert dialog
  }

  // _openCamera(BuildContext context) async {
  //   var picture = await picker.getImage(
  //       source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
  //   if (picture != null) {
  //     File cropped = await ImageCropper.cropImage(
  //         sourcePath: picture.path,
  //         aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 1),
  //         compressQuality: 100,
  //         maxHeight: 400,
  //         maxWidth: 400,
  //         androidUiSettings: AndroidUiSettings(
  //           toolbarColor: Color(0xff00B1D2),
  //           toolbarTitle: 'Expilert Image Cropper',
  //           toolbarWidgetColor: Color(0xffFDDB27),
  //           backgroundColor: Colors.white,
  //         ));
  //     this.setState(() {
  //       imageFile = cropped;
  //     });
  //   }
  //   Navigator.of(context).pop(); //it removes alert dialog
  // }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _selectImage(context, ImageSource.gallery);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _selectImage(context, ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _imageAvailibilty() {
    if (imageFile == null) {
      return Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.grey),
        child: Text(
          'NO IMAGE SELECTED',
          style: TextStyle(
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.file(
          imageFile,
          width: 400,
          height: 400,
        ),
      );
    }
  }

  String textPiece;
  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(imageFile);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          textPiece = block.text;
          print(textPiece);
        }
      }
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageItemAddScreen(
              expiryValue: textPiece,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _imageAvailibilty(),
                  SizedBox(
                    height: 35.0,
                  ),
                  AddScreenButton(
                    title: 'Select a Picture',
                    onPressed: () {
                      _showChoiceDialog(context);
                      setState(() {
                        manualButton = false;
                        processButton = true;
                      });
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Visibility(
                    visible: manualButton,
                    child: AddScreenButton(
                      title: 'Fill Manually',
                      onPressed: () {
                        Navigator.pushNamed(context, ManualAddScreen.id);
                      },
                    ),
                  ),
                  Visibility(
                    visible: processButton,
                    child: AddScreenButton(
                      title: 'Process',
                      onPressed: readText,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
            (_inProcess)
                ? Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.95,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center(),
          ],
        ),
      ),
    );
  }
}
