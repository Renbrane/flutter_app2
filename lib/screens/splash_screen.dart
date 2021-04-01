import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app2/generated/l10n.dart';
import 'package:flutter_app2/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), toHomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
              ),
              Text(
                S.of(context).splashScreenAppName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0,
                ),
              )
            ]),
      ),
    );
  }
}

void toHomeScreen() {
  MaterialPageRoute(
    builder: (BuildContext context) => HomeScreen(),
  );
}
