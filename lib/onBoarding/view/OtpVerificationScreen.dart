import 'package:creator/onBoarding/controller/OtpVerificationController.dart';
import 'package:creator/onBoarding/controller/TimerController.dart';
import 'package:creator/onBoarding/view/SelectScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppComponents.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppFonts.dart';
import '../../utils/BlurBackground.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  var controller = Get.put(OtpVerificationController());
  var timerController = Get.put(TimerController());
  FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardActions(
        config: KeyboardActionsConfig(
          actions: [
            KeyboardActionsItem(focusNode: node)
          ]
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_image.png"),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [

                BlurBackground(
                  blurAmount: 10.0,
                  borderRadius: 20.0,
                  padding: 16.0,
                  imagePath: 'assets/images/splash_logo.png',
                  belowMargin: MediaQuery.of(context).size.height * 0.12,
                  aboveMargin: 125,
                  showBackButton: true,
                  onPressed: (){
                    print("tap detect");

                  },

                  child: Column(
                    children: [
                      const SizedBox(
                        height: 180,
                      ),

                      ///otp verification text
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppConstants.otpVerification,
                            style: TextStyle(
                              color: AppColors.white,
                              fontFamily: AppFonts.montserratBold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),

                      ///otp verification desc
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 40),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppConstants.otpVerificationDesc,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontFamily: AppFonts.montserrat,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      ///enter otp
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 2, bottom: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppConstants.enterOtp,
                            style: TextStyle(
                              color: AppColors.white,
                              fontFamily: AppFonts.montserrat,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      ///enter pin
                      pinTextField(context),
                      const SizedBox(height: 8,),

                      ///timer
                      Obx(() => timerController.showResend.value
                          ? InkWell(
                        onTap: (){
                          timerController.showResend.value = false;
                          timerController.timeRemaining.value = 30;
                          timerController.startTimer();
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: const Text(
                              "Resend otp?",
                              style: TextStyle(
                                  color: AppColors.carrotRed,
                                  fontFamily: AppFonts.montserratRegular,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      )
                          : Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/timer.png",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "00:${timerController.timeRemaining.value}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.montserratRegular,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      )),

                      ///submit
                      submitBtn(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 20,
                  child: Container(
                      height: 60,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: AppComponents.backButton()),

                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pinTextField(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22),
          child: PinCodeTextField(
            focusNode: node,
            appContext: context,
            length: 6,
            onChanged: (value) {
              print("otp $value");
            },
            onCompleted: (value) {
              controller.otp.value = value;

              // Handle PIN submission
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              borderWidth: 0.5,
              fieldHeight: 40,
              fieldWidth: 40,
              activeColor: Colors.blue,
              inactiveColor: AppColors.shadow,
              selectedColor: Colors.blue,
            ),
            keyboardType: TextInputType.number,
            textStyle: const TextStyle(fontSize: 20, color: AppColors.grey),
            obscureText: true,
            obscuringCharacter: "*",
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }

  Widget submitBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
      child: InkWell(
        onTap: () async {
          if (controller.otp.value.isEmpty && controller.otp.value.length < 6) {
            Fluttertoast.showToast(msg: "Please enter valid otp");
          } else {
            timerController.startTimer();
            controller.submitOtp();
          }
        },
        child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [AppColors.carrotRed, AppColors.btnGradient],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
                padding:
                    EdgeInsets.only(left: 50.0, right: 50, top: 15, bottom: 15),
                child: Center(
                  child: Text(
                    AppConstants.submit,
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: AppFonts.montserratSemibold,
                    ),
                  ),
                ))),
      ),
    );
  }
}
