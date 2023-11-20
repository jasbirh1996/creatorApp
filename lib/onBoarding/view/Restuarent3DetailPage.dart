import 'dart:io';

import 'package:creator/network/model/restaurant/CreateRestaurantProfile.dart';
import 'package:creator/onBoarding/controller/CommonController.dart';
import 'package:creator/onBoarding/controller/ResturantDetailController.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:creator/utils/AppUtils.dart';
import 'package:creator/utils/GenericTexwidget.dart';
import 'package:creator/utils/OptionSelector.dart';
import 'package:creator/utils/RadioBottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppFonts.dart';
import '../../utils/BlurBackground.dart';
import '../../utils/CustomDialog.dart';
import '../../utils/GenericTextField.dart';
import '../controller/Restuarant2Controller.dart';
import 'CustomDropDown.dart';
import 'DropDownWithCheck.dart';
import 'LoginScreen.dart';

class ResturentDetailPage3 extends StatefulWidget {
  ResturentDetailPage3({super.key});

  @override
  State<ResturentDetailPage3> createState() => _ResturentDetailPageState3();
}

class _ResturentDetailPageState3 extends State<ResturentDetailPage3> {
  //RestaurantController controller = Get.put(RestaurantController());
  TextEditingController workingSince = TextEditingController();
  TextEditingController openingHours = TextEditingController();
  TextEditingController openingHoursTo = TextEditingController();
  String selectedValue = 'Bar';
  List<String> dropdownItems = ['Bar', 'Club', 'Pub'];
  List<String?> images = List.filled(2, null);
  List<String> selectedDays = [];
  String selectedDay = "";
  var controller = Get.put(Restuarant2Controller());
  var restaurantFirstPageController = Get.put(ResturentDetailController());
  var optionController = Get.put(CommonController());
  var workingSinceNode = FocusNode();

  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool validate() {
      if (workingSince.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter working since");
        return false;
      } else if (openingHours.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter open hours from");

        return false;
      }
      else if (int.parse(workingSince.text) > 2023) {
        Fluttertoast.showToast(msg: "Please enter correct date");

        return false;
      }

      else if (openingHoursTo.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter open hours to");

        return false;
      } else if (optionController.selectedOptions.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter default days");

        return false;
      } else if (selectedValue.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter restaurant tags");

        return false;
      } else if (controller.selectedImages.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter images");

        return false;
      } else {
        return true;
      }
    }

    List<Widget> formFields = [
      GenericTextField(
        controller: workingSince,
        hint: AppConstants.enterWorkingSince,
        label: AppConstants.workingSince,
        textInputType: TextInputType.number,
        node: workingSinceNode,
      ),



     /* InkWell(
        onTap: () {
          controller.showDatePickerDialogWithCallback(
              context, (year) => {workingSince.text = year.year.toString()});
        },
        child: GenericTextWidget(
          controller: workingSince,
          hint: AppConstants.enterWorkingSince,
          label: AppConstants.workingSince,
          textInputType: TextInputType.number,
        ),
      ),*/


      OptionSpinner(
          options: [
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturdat",
            "Sunday"
          ],
          onItemsSelected: (value) {
            optionController.selectedOptions.clear();

            optionController.selectedOptions.value = List.from(value);
          },
          heading: "Default Running Days"),
      SizedBox(
        height: 22,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Opening Hours",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: AppFonts.montserratMedium),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.showTimePickerDialogWithCallback(context, (time) {
                    openingHours.text =
                        time.hour.toString() + ": " + time.minute.toString();
                  });
                },
                child: GenericTextWidget(
                    controller: openingHours,
                    hint: "HH:MM",
                    label: AppConstants.from,
                    model: "",
                    textInputType: TextInputType.number,
                    widthMatchParent: false),
              ),
              InkWell(
                onTap: () {
                  controller.showTimePickerDialogWithCallback(context, (time) {
                    openingHoursTo.text =
                        time.hour.toString() + ": " + time.minute.toString();
                  });
                },
                child: GenericTextWidget(
                    controller: openingHoursTo,
                    hint: "HH:MM",
                    textInputType: TextInputType.number,
                    label: AppConstants.to,
                    model: "",
                    widthMatchParent: false),
              ),
            ],
          ),
        ],
      ),

      RadioBottomSheet(options: controller.tagString, onItemSelected: (value){

      }, heading: "tag"),
      SizedBox(height: 15,),

      /*CustomDropdown(
        label: AppConstants.restaurantTags,
        items: dropdownItems,
        model: AppConstants.detailsPage2,
        selectedValue: selectedValue,
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
      ),*/

      Container(
        margin: EdgeInsets.only(left: 15),
          child: Text("Restaurant Images",style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.montserrat,
            fontSize: 12
          ),)),
      SizedBox(height: 8,),

      Obx(
        () => controller.selectedImages.isNotEmpty
            ? Container(
          margin: EdgeInsets.only(left: 15),
                height: 150,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  padding: EdgeInsets.all(4.0),
                  children: List.generate(
                    controller.selectedImages.length,
                    (index) => InkWell(
                      onTap: () {
                        if (controller.selectedImages.length > 4) {
                          Fluttertoast.showToast(
                              msg: "You have reached maximum limit");
                        } else {
                          controller.pickImageFromGallery(context);
                        }
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: AppColors.grey, width: 0.5),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 8,),
                                          InkWell(
                                            onTap: (){
                                              controller.selectedImages.remove(controller.selectedImages[index]);
                                            },
                                            child: const Icon(
                                              Icons.highlight_remove_rounded,
                                              color: AppColors.carrotRed,
                                            ),
                                          ),

                                        ],
                                      )
                                    ),
                                    Image.file(
                                      File(controller
                                          .selectedImages[index].filePath),
                                      fit: BoxFit.fitWidth,
                                      height: 80,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Uploaded Image",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 13,
                                        fontFamily: AppFonts.montserratSemibold,
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : InkWell(
          onTap: (){
            if (controller.selectedImages.length > 4) {
              Fluttertoast.showToast(
                  msg: "You have reached maximum limit");
            } else {
              controller.pickImageFromGallery(context);
            }
          },
              child:
              Row(
                children: [
                  SizedBox(width: 15,),
                  Expanded(child: Container(
                    height: 150,
                    child: Card(

                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: AppColors.grey, width: 0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/upload_img.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Upload Image",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 13,
                                  fontFamily: AppFonts.montserratSemibold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                    ),
                  ),),
                  Expanded(child: Text(""))
                ],
              )
            ),
      )



    ];

    return SafeArea(
        child: Scaffold(
      body: KeyboardActions(
        config: KeyboardActionsConfig(
          actions: [
            KeyboardActionsItem(focusNode: workingSinceNode)
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
                    belowMargin: MediaQuery.of(context).size.height * 0.13,
                    aboveMargin: 117,
                    showBackButton: true,
                    onPressed: () {},
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),

                        ///general details
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppConstants.generalDetails,
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: AppFonts.montserratBold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),

                        ///enter MobileNo To Continue
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 20.0, top: 10, bottom: 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppConstants.enterResDetails,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: AppFonts.montserrat,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  children: formFields,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppUtils.averageSize,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: AppComponents.createButton("Submit", () {
                            if (validate()) {
                              controller.createRestaurantProfile(
                                  RestaurantRequest(
                                      profilePic: controller.profileImage,
                                      firstname: controller.owfirstName,
                                      lastname: controller.owLastName,
                                      businessName: controller.businessName,
                                      email: controller.businessEmail,
                                      restaurantWebsite: controller.bussWeb,
                                      restaurantAddress: controller.address,
                                      restaurantDescription: controller.busnessDescription,
                                      restaurantWorkingSince: workingSince.text,
                                      restaurantOpeningFrom: openingHours.text,
                                      restaurantOpeningTo: openingHoursTo.text,
                                      restaurantTags: "",
                                      images: restaurantFirstPageController
                                          .imageList),
                                  context);
                            }
                          }),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 15,
                    child: Container(
                        height: 60,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: AppComponents.backButton()),
                          ],
                        )),
                  ),
                ],
              ),
            )),
      ),
    ));
  }

  Widget uploadImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            AppConstants.addMoreImages,
            style: TextStyle(
                color: AppColors.white,
                fontFamily: AppFonts.montserrat,
                fontSize: 12),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: controller.selectedImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    // pick image
                  }
                },
                child: controller.selectedImages[index].filePath == "filePath"
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow.withOpacity(0.7),
                                // Adjust the offset for top-left shadow
                              ),
                              BoxShadow(
                                color: Colors.transparent.withOpacity(0.5),
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/restaurant_images/upload_img.png",
                              height: 50,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Center(
                                child: Text(
                                  AppConstants.uploadImages,
                                  style: TextStyle(
                                      color: AppColors.grey,
                                      fontFamily: AppFonts.montserrat,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          controller.selectedImages[index].fileMain,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
