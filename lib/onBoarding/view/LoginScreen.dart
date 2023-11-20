import 'package:creator/onBoarding/controller/LoginController.dart';
import 'package:creator/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../network/model/restaurantLoginReqBody.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppComponents.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppFonts.dart';
import '../../utils/BlurBackground.dart';
import '../../utils/FlutterMotionToast.dart';
import '../../utils/TextLabels.dart';
import 'OtpVerificationScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var controller = Get.put(LoginController());
  var mobileController = TextEditingController();
  String selectedDialCode = "91";
  FocusNode mobileNumberFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardActions(
        config: KeyboardActionsConfig(
          actions: [
            KeyboardActionsItem(focusNode:mobileNumberFocus)
          ]
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_image.png"),
                fit: BoxFit.fill),
          ),
          child: BlurBackground(
            blurAmount: 10.0,
            borderRadius: 20.0,
            padding: 16.0,
            imagePath: 'assets/images/splash_logo.png',
            belowMargin: MediaQuery.of(context).size.height * 0.05,
            aboveMargin: MediaQuery.of(context).size.height * 0.1,
            showBackButton: false,
            onPressed: (){

            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: RichText(
                        text: const TextSpan(
                      children: [
                        TextSpan(
                          text: AppConstants.welcome,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.montserratBold,
                            fontSize: 24,
                          ),
                        ),
                        TextSpan(
                          text: AppConstants.back,
                          style: TextStyle(
                            color: AppColors.carrotRed,
                            fontFamily: AppFonts.montserratBold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    )),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      AppConstants.loginCreate,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontFamily: AppFonts.montserrat,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: TextLabels(label: AppConstants.mobileNumber)),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  mobileNumberTextField(),
                  const SizedBox(
                    height: 24,
                  ),
                  agreeCheckBox(),

                  getOtpBtn(context),
                  const SizedBox(
                    height: 20,
                  ),
                  orDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  socialLogins(),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding mobileNumberTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.textField,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.shadow, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                // Adjust the offset for top-left shadow
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
          child: IntlPhoneField(
            controller: mobileController,
            focusNode: mobileNumberFocus,
            flagsButtonPadding: const EdgeInsets.only(left: 8,right: 0),
            dropdownIconPosition: IconPosition.trailing,
            dropdownTextStyle: const TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.montserratMedium,
                color: AppColors.white),
            style: const TextStyle(
                fontSize: 18,
                fontFamily: AppFonts.montserratMedium,
                color: AppColors.white),
            autovalidateMode: AutovalidateMode.disabled,
            decoration: const InputDecoration(

              hintText: AppConstants.enterMobileNumber,
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.montserratMedium,
                  color: AppColors.white),
              focusedBorder: InputBorder.none,
              counterText: '',
            ),
            initialCountryCode: "IN",
            disableLengthCheck: false,
            onChanged: (value) {},
            showCountryFlag: true,
            dropdownIcon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.orange,
            ),
            onCountryChanged: (value) {
              selectedDialCode = value.dialCode;
            },
          )),
    );
  }

  Row agreeCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 8,
        ),
        Obx(
          () => Checkbox(
            value: controller.isChecked.value,
            checkColor: Colors.white,
            activeColor: Colors.green,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 1.0, color: Colors.white),
            ),
            onChanged: (bool? value) {
              controller.isChecked.value = value!;
            },
          ),
        ),
        RichText(
          text: const TextSpan(
            text: 'Agree with the ',
            style: TextStyle(
              color: AppColors.grey,
              fontFamily: AppFonts.montserrat,
              fontSize: 10,
            ),
            children: [
              TextSpan(
                text: 'Terms & Conditions',
                style: TextStyle(
                  color: AppColors.carrotRed,
                  fontFamily: AppFonts.montserrat,
                  fontSize: 10,
                ),
              ),
              TextSpan(
                text: ' & ',
                style: TextStyle(
                  color: AppColors.grey,
                  fontFamily: AppFonts.montserrat,
                  fontSize: 10,
                ),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  color: AppColors.carrotRed,
                  fontFamily: AppFonts.montserrat,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding getOtpBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () async {
          if (mobileController.text.isNotEmpty &&
              mobileController.text.length == 10) {
            if (controller.isChecked.value) {
              // make network call
              controller.login(RestaurantLoginReqBody(
                  country_code: "+91", mobileNumber: mobileController.text));
            } else {
              Fluttertoast.showToast(msg: "Please agree terms");
            }
          } else {
            Fluttertoast.showToast(msg: "Please Enter Valid Mobile Number");
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
                    AppConstants.getOtp,
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: AppFonts.montserratBold,
                    ),
                  ),
                ))),
      ),
    );
  }

  Padding orDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              endIndent: 8,
              color: Colors.grey,// Adjust spacing after the divider
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'OR',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.grey),
            ),
          ),
          Expanded(
            child: Divider(
              indent: 8,
              color: Colors.grey,// Adjust spacing before the divider
            ),
          ),
        ],
      ),
    );
  }

  Row socialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Obx(() => controller.isIOs.value ? Padding(
         padding: const EdgeInsets.only(right: 25.0),
         child: Container(
           height: 50,
           width: 50,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(5.0),
             gradient: const LinearGradient(
               colors: [
                 AppColors.shadow,
                 Color(0xff1c1c1c00),
               ],
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
             ),
             border: Border.all(
               color: AppColors.grey,
               width: 0.3,
             ),
           ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Image.asset(
               'assets/images/apple.png',
               fit: BoxFit.contain,
             ),
           ),
         ),
       ): Container()

       ),
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              gradient: const LinearGradient(
                colors: [
                  AppColors.shadow,
                  Color(0xff1c1c1c00),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: AppColors.grey,
                width: 0.3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/google.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: const LinearGradient(
              colors: [
                AppColors.shadow,
                Color(0xff1c1c1c00),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: AppColors.grey,
              width: 0.3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/facebook.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
