

import 'dart:io';

import 'package:creator/network/ApiEndPoint.dart';
import 'package:creator/network/Network.dart';
import 'package:creator/network/model/restaurantLoginReqBody.dart';
import 'package:creator/network/model/restaurantLoginResponse.dart';
import 'package:creator/onBoarding/view/OtpVerificationScreen.dart';
import 'package:creator/pref/SharedPref.dart';
import 'package:creator/utils/AppUtils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isChecked = false.obs;
  var response = RestaurantLoginResponse().obs;
  var client = NetworkClass();// Create an instance of NetworkClass
  var isIOs = false.obs;

  void login(RestaurantLoginReqBody reqBody) async {
    try {
      var data = await client.postRequest(ApiEndPoint.restaurantEventLogin, reqBody);
      if (data.statusCode == 200) {
        var resData = RestaurantLoginResponse.fromJson(data.data).data?.accessToken;
        if (resData != null) {
          SharedPref.saveAccessToken(resData);
          Get.to(OtpVerificationScreen());
        }
      }
    } catch (exception) {
      // response.value = RestaurantLoginResponse.fromJson(exception.response?.data);
      AppUtils.showToast("Something went wrong");
    }
  }

  @override
  void onInit() {
    if(Platform.isIOS){
      isIOs.value = true;
    }
    super.onInit();
  }
}

