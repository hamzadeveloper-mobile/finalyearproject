import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'nav.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController iconcontroller, colorcontroller;
  Animation iconanimation, coloranimation;
  @override
  void initState() {
    iconcontroller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    colorcontroller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    iconanimation = CurvedAnimation(
      parent: iconcontroller,
      curve: Curves.bounceOut,
    );

    coloranimation = ColorTween(
      begin: Color(0xff007c9b),
      end: Color(0xff00B1D2),
    ).animate(colorcontroller);

    iconcontroller.forward();
    colorcontroller.forward();

    iconcontroller.addListener(() {
      setState(() {});
    });

    colorcontroller.addListener(() {
      setState(() {});
    });
    super.initState();

    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacementNamed(context, Nav.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //stack is used for having one or more widget on top
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: coloranimation.value,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.track_changes,
                        size: iconanimation.value * 90,
                        color: Color(0xffFDDB27),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                        ),
                      ),
                      TypewriterAnimatedTextKit(
                        speed: Duration(milliseconds: 160),
                        text: ['E X P I L E R T'],
                        textStyle: TextStyle(
                          color: Color(0xffFDDB27),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poiret One',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    JumpingDotsProgressIndicator(
                      numberOfDots: 15,
                      color: Color(0xffFDDB27),
                      fontSize: 50.0,
                      dotSpacing: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      'now nothing get\'s expired!!!',
                      style: TextStyle(
                        color: Color(0xffFDDB27),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat Alternates',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
