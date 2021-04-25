import 'package:expilert/manual_item_addscreen.dart';
import 'package:expilert/nav.dart';
import 'package:expilert/notificationscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:expilert/image_processed_item _addscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ExpilertApp());
}

class ExpilertApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff00B1D2), accentColor: Color(0xffFDDB27)),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        Nav.id: (context) => Nav(),
        ManualAddScreen.id: (context) => ManualAddScreen(),
        ImageItemAddScreen.id: (context) => ImageItemAddScreen(),
        NotificationPage.id: (context) => NotificationPage(),
      },
    );
  }
}
