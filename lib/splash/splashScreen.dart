import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
