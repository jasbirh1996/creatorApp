import 'dart:io';

import 'package:creator/dashBoard/eventCreator/EventCreatorDashBoard.dart';
import 'package:creator/network/model/event_creator/CreateProfileRequest.dart';
import 'package:creator/network/model/event_creator/CreateProfileResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../network/ApiEndPoint.dart';
import '../../network/Network.dart';
import '../../network/model/file_model.dart';
import '../../utils/AppConstants.dart';
import '../../utils/FlutterMotionToast.dart';

class EventCreatorController extends GetxController{
  var client = NetworkClass(); // Create an instance of NetworkClass
  File? profilePic;
  final picker = ImagePicker();
  List<FileModel> selectedImages = <FileModel>[].obs;

  var isLoading = false.obs;
  var path = "".obs;
  var profilePicPath = "".obs;
  List<ImageUrl> imageList = [];

  void createProfile(CreateProfileRequest reqBody) async {
    try {
      var data = await client.postRequest(ApiEndPoint.createEventCreator, reqBody);
      if (data.statusCode == 200) {
        var resData = CreateProfileResponse.fromJson(data.data);
        if (resData.status == 200) {
          // profile created
          print("Event creator Created");
          print(resData.message);
          Get.to(EventCreatorDashBoard());
        }
      }
    } catch (exception) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
  pickImage({bool camera = false, BuildContext? context}) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? pickedFile = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );

      if (pickedFile == null) {
        // User did not pick an image, handle accordingly
        path.value = "";

        return;
      }

      profilePic = File(pickedFile.path);

      path.value = profilePic!.absolute.path;


      if (profilePic != null) {
        await uploadProfilePicture(profilePic!).then((value) {
          profilePicPath.value = value;
          print("image path ${value}");
        });
      }
    } catch (e) {

      print(e);
    }
  }


  Future pickImageFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      if(xfilePick.length <6){
        var maxCount = selectedImages.length + xfilePick.length;
        print("max count $maxCount");
        if (maxCount < 6) {
          xfilePick.forEach((element) {
            FileModel fileModel = FileModel(
                fileType: "image",
                filePath: element.path, // Assuming you want to add the first image
                fileMain: File(element.path),
                fileThumbnail: File(element.path)
            );
            selectedImages.add(fileModel);
          }
          );

        } else {
          FlutterMotionToast.showToast(
            context: context,
            message: AppConstants.maxImageCount,
            isSuccess: false,
          );
        }
      }
      else {
        FlutterMotionToast.showToast(
          context: context,
          message: AppConstants.maxImageCount,
          isSuccess: false,
        );
      }


    } else {
      FlutterMotionToast.showToast(
        context: context,
        message: 'Nothing is selected',
        isSuccess: false,
      );
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