
import 'dart:async';
import 'package:face_detection/login_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()
  { super.initState();
  Future.delayed(Duration(seconds: 10), () {
    // Navigate to the main content of your app
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset('assets/images/face.jpg'),
            SizedBox(height: 10,),
            Text("Emotion Detection"),
          ],
        ),
      ),
    );
  }
}
