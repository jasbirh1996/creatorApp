import 'package:creator/onBoarding/view/LoginScreen.dart';
import 'package:creator/onBoarding/view/OtpVerificationScreen.dart';
import 'package:creator/onBoarding/view/PermissionScreen.dart';
import 'package:creator/onBoarding/view/SelectScreen.dart';
import 'package:creator/onBoarding/view/Splash.dart';
import 'package:creator/onBoarding/view/TutorialScreen.dart';
import 'package:creator/routes/AppRoutes.dart';
import 'package:creator/utils/AppFonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return  GetMaterialApp(
   /*   initialRoute: AppRoutes.splashScreen,
      getPages: [
        GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
        GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
        GetPage(name: AppRoutes.otpScreen, page: () => OtpVerificationScreen()),
        GetPage(name: AppRoutes.selectScreen, page: () => SelectScreen()),
        GetPage(name: AppRoutes.tutorialScreen, page: () => OnBoardingRestuarant()),
        GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
        GetPage(name: AppRoutes.permissionScreen, page: () => PermissionScreen()),
      ],*/
      theme:ThemeData(primarySwatch: Colors.blue,fontFamily: AppFonts.montserrat),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

