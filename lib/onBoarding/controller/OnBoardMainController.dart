import 'package:creator/utils/AppUtils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OnBoardMainController extends GetxController{

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      AppUtils.showToast("Permission Denied",title: "Denied");
      // Permission denied
    } else if (permission == LocationPermission.deniedForever) {
      AppUtils.showToast("Permission Denied",title: "Denied");
      // Permission denied permanently
    } else {
      AppUtils.showToast("Permission Granted",title: "Granted");
      // Permission granted
      Position position = await Geolocator.getCurrentPosition();
      // Do something with the position data
    }
  }
}