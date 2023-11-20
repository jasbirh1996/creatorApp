import 'package:creator/onBoarding/controller/OnBoardMainController.dart';
import 'package:creator/onBoarding/view/TutorialScreen.dart';
import 'package:creator/pref/SharedPref.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:creator/utils/AppConstants.dart';
import 'package:creator/utils/AppUtils.dart';
import 'package:creator/utils/BlurBackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppFonts.dart';

class PermissionScreen extends StatelessWidget {
   PermissionScreen({super.key});
   var controller = Get.put(OnBoardMainController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_image.png"),
              fit: BoxFit.fill),
        ),
        child: Container(
            child: BlurBackground(
          blurAmount: 10.0,
          borderRadius: 20.0,
          padding: 16.0,
          imagePath: 'assets/images/splash_logo.png',
          belowMargin: 106,
          aboveMargin: 100,
              onPressed: (){

              },
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                AppComponents.textWithBold(
                    AppConstants.permissionRequired,24),
                SizedBox(height: AppUtils.averageSize,),

                AppComponents.textWithRegular(
                    AppConstants.allow_this,14),
                SizedBox(height: 24,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_rounded,color: AppColors.carrotRed,),
                    SizedBox(width: AppUtils.averageSize,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2,),
                        AppComponents.textWithBold(
                            AppConstants.location, 16),
                        SizedBox(height: 8,),
                        AppComponents.textWithRegular(AppConstants.locationContent, 12)

                      ],
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.notifications_active_rounded,color: AppColors.carrotRed,),
                    SizedBox(width: AppUtils.averageSize,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2,),
                        AppComponents.textWithBold(
                            AppConstants.notification, 16),
                        SizedBox(height: 8,),
                        AppComponents.textWithRegular(AppConstants.notificationContent, 12)

                      ],
                    )
                  ],
                ),
                SizedBox(height: 40,),
                Row(

                  children: [
                    Expanded(
                        child: AppComponents.getTransparentButton("Deny", (){
                          Get.to(OnBoardingRestuarant());
                        })),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        child: AppComponents.createButton('Allow',(){
                          SharedPref.savePermissionState("true");

                          Get.to(OnBoardingRestuarant());
                          // controller.requestLocationPermission();
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        )),
      ),
    );
  }
}
