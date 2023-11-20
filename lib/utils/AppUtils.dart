import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'AppColor.dart';
import 'AppFonts.dart';

class AppUtils {
    static const buttonGradient =  LinearGradient(
      colors: [AppColors.carrotRed, AppColors.btnGradient],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    static const double averageSize = 12;

    static void showToast(String message, {String? title = "Error"}) {
      if (message != null) {
        Get.snackbar(title ?? "Error", message,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            borderColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    }




}