import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay the navigation for 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Get.offAndToNamed('/login_signup');
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
