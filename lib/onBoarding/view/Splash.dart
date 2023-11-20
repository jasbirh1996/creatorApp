
import 'package:creator/onBoarding/view/PermissionScreen.dart';
import 'package:creator/pref/SharedPref.dart';
import 'package:creator/routes/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'TutorialScreen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove the following line to show the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make the status bar transparent// Use dark icons on the status bar
      systemNavigationBarColor: Colors.transparent, // Make the system navigation bar transparent
      // Use dark icons on the system navigation bar
    ));

    Future.delayed(Duration(seconds: 4), () {
      SharedPref.getPermissionState().then((value) {
        if(value != null){
          Get.off(OnBoardingRestuarant());
        }else{
          Get.off(PermissionScreen());
        }
      });
      // Navigate to the next screen
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/splash_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Image.asset("assets/images/splash_logo.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


