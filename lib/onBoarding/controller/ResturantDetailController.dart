import 'dart:io';

import 'package:creator/network/ApiEndPoint.dart';
import 'package:creator/network/model/event_creator/CreateProfileRequest.dart';
import 'package:creator/network/model/restaurant/RestaurantTags.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../network/Network.dart';

class ResturentDetailController extends GetxController{
  File? profilePic;
  var mapLocation = "".obs;

  var isLoading = false.obs;
  var path = "".obs;
  var tempFile = "";
  var profilePicPath = "".obs;
  List<ImageUrl> imageList = [];
  var client = NetworkClass();


  pickImage({bool camera = false, BuildContext? context}) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? pickedFile = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );

      if (pickedFile == null) {
        // User did not pick an image, handle accordingly
        path.value = "";
        tempFile = "";
        return;
      }

      profilePic = File(pickedFile.path);

      path.value = profilePic!.absolute.path;
      tempFile = path.value;

      if (profilePic != null) {
        await uploadProfilePicture(profilePic!).then((value) {
          profilePicPath.value = value;
          print("image path ${value}");
        });
      }
    } catch (e) {
      tempFile = "";
      print(e);
    }
  }



  pickImageMultipleImages({bool camera = false, BuildContext? context}) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? pickedFile = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      profilePic = File(pickedFile?.path ?? '');

      if (profilePic != null) {
        await uploadProfilePicture(profilePic!).then((value){
          imageList.add(ImageUrl(url: value));
        });

      }

    } catch (e) {
      print(e);

    }
  }

  Future<String> uploadProfilePicture(File image) async {
    var profilePath = '';
    try {
      final response = await client.uploadfile( ApiEndPoint.uploadPhotoRestaurant, 'image', image );
      profilePath = response.data?.imageUrl ?? '';
    } catch (ex) {
      print(ex.toString());
    }
    return profilePath;
  }




}