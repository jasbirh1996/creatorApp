import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TimerController extends GetxController {
  var timeRemaining = 30.obs;
  var showResend = false.obs;

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        timer.cancel();
        onTimerFinish();
      }
    });
  }

  void onTimerFinish() {
    showResend.value = true;
    // Add your callback logic here
  }
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }
}