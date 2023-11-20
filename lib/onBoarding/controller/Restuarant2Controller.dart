import 'dart:io';

import 'package:creator/dashBoard/restuarent/RestuarentDashBoard.dart';
import 'package:creator/network/model/restaurant/CreateRestaurantProfile.dart';
import 'package:creator/onBoarding/view/RequestAccepted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../network/ApiEndPoint.dart';
import '../../network/Network.dart';
import '../../network/model/file_model.dart';
import '../../network/model/restaurant/RestaurantTags.dart';
import '../../utils/AppConstants.dart';
import '../../utils/CustomDialog.dart';
import '../../utils/FlutterMotionToast.dart';

class Restuarant2Controller extends GetxController {
  final picker = ImagePicker();
  List<FileModel> selectedImages = <FileModel>[].obs;
  List<PickImagesPath> selectedImagesPath = [];
  var isSuccess = "".obs;
  var profileImage = "";
  var owfirstName = "";
  var owLastName = "";
  var businessName = "";
  var businessEmail = "";
  var bussWeb = "";
  var address = "";
  var busnessDescription = "";
  List<Tag> taglist = <Tag>[].obs;
  List<String> tagString = <String>[].obs;



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

  getTag()async{

    try {
      final response = await client.getRequest( "restaurant/restaurantCategoryTagList" );
      if(response.statusCode == 200){
        var data = RestaurantCategoryTag.fromJson(response.data);
        taglist = data.tagList;
        taglist.forEach((element) {
          tagString.add(element.name);
        });

      }


    } catch (ex) {
      print(ex.toString());
    }
  }

  @override
  void onInit() {
    getTag();
    super.onInit();
  }



/*
  Future pickImageFromGallery(BuildContext context, int index) async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      // Check if an entry with the same index already exists
      int existingIndex =
      selectedImages.indexWhere((element) => element.index == index);

      if (existingIndex != -1) {
        // Replace the existing entry
        FileModel fileModel = FileModel(
          fileType: "image",
          filePath: xfilePick[0].path, // Assuming you want to replace it with the first image
          fileMain: File(xfilePick[0].path),
          fileThumbnail: File(xfilePick[0].path),
          index: index,
        );
        selectedImages[existingIndex] = fileModel;
      } else {
        // Add a new entry
        if (selectedImages.length < 6) {
          FileModel fileModel = FileModel(
            fileType: "image",
            filePath: xfilePick[0].path, // Assuming you want to add the first image
            fileMain: File(xfilePick[0].path),
            fileThumbnail: File(xfilePick[0].path),
            index: index,
          );
          selectedImages.add(fileModel);
        } else {
          FlutterMotionToast.showToast(
            context: context,
            message: AppConstants.maxImageCount,
            isSuccess: false,
          );
        }
      }
    } else {
      FlutterMotionToast.showToast(
        context: context,
        message: 'Nothing is selected',
        isSuccess: false,
      );
    }
  }
*/

  var client = NetworkClass();

  void createRestaurantProfile(
      RestaurantRequest request, BuildContext context) async {
    try {
      var data =
          await client.postRequest(ApiEndPoint.restaurantCreator, request);
      if (data.statusCode == 200) {
        print("success");
        print(data.statusMessage);
        isSuccess.value = "sucess";

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              showGif: true,
              gifImage: 'assets/images/waiting.gif',
              label: AppConstants.waiting,
              description: AppConstants.reviewMessage,
              image: '',
            );
          },
        );

        Future.delayed(Duration(seconds: 5))
            .then((value) => Get.to(RequestAccepted()));
      }
    } catch (exception) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }




  Future<DateTime?> showDatePickerDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }

  Future<int?> showDatePickerDialogWithCallback(BuildContext context, Function(DateTime) callback) async {
    final DateTime? picked = await showDatePickerDialog(context);
    if (picked != null) {
      callback(picked);
      return picked.year;
    }
    return null;
  }


  Future<TimeOfDay?> showTimePickerDialog(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      return picked;
    }
    return

      null;
  }

  Future<void> showTimePickerDialogWithCallback(BuildContext context, Function(TimeOfDay) callback) async {
    final TimeOfDay? pickedTime = await showTimePickerDialog(context);
    if (pickedTime != null) {
      callback(pickedTime);
      print('Selected time: ${pickedTime.hour}:${pickedTime.minute}');
    }
  }


}

class PickImagesPath {
  String? url;

  PickImagesPath({
    this.url,
  });

  factory PickImagesPath.fromJson(Map<String, dynamic> json) => PickImagesPath(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class FileWithIndex {}
