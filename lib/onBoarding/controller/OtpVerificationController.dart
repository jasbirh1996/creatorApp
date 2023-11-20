
import 'package:creator/dashBoard/eventCreator/EventCreatorDashBoard.dart';
import 'package:creator/dashBoard/restuarent/RestuarentDashBoard.dart';
import 'package:creator/onBoarding/view/SelectScreen.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../network/ApiEndPoint.dart';
import '../../network/Network.dart';
import '../../network/model/RestaurantVerifyResponse.dart';
import '../../network/model/restuarantVerifyOtpReqBody.dart';



class OtpVerificationController extends GetxController{
  var otp = "".obs;
  var client = NetworkClass();


  void submitOtp() async {

    try {
      var response = await client.postRequest(ApiEndPoint.restaurantVerifyOtp, RestaurantVerifyOtpReqBody(otp: otp.value));

      if (response.statusCode == 200) {
        var resData = RestaurantVerifyResponse.fromJson(response.data);
        print("success");
        print(resData.toJson());
        if(resData.userDetails?.userType == 1){
          Get.off(RestaurantDashBoard());
        } else if(resData.userDetails?.userType == 2){
          Get.off(EventCreatorDashBoard());
        }else{
          Get.off(SelectScreen());
        }


      } else if (response.statusCode == 403) {
        Fluttertoast.showToast(msg: response.statusMessage.toString());
      } else {
        // Handle other status codes if needed
        Fluttertoast.showToast(msg: "Unexpected status code: ${response.statusCode}");
      }
    } on DioError catch (e) {
      // Handle DioError specifically
      if (e.response != null && e.response!.statusCode == 403) {
        Fluttertoast.showToast(msg: "Invalid Otp");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      // Handle other exceptions
      Fluttertoast.showToast(msg: "Unexpected error: $e");
    }
  }



  }