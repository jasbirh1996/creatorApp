import 'dart:io';

import 'package:creator/network/model/event_creator/CreateProfileRequest.dart';
import 'package:creator/onBoarding/controller/EventCreatorController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppComponents.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppFonts.dart';
import '../../utils/AppUtils.dart';
import '../../utils/BlurBackground.dart';
import '../../utils/GenericTextField.dart';
import '../controller/ResturantDetailController.dart';
import 'LoginScreen.dart';
import 'Restuarent3DetailPage.dart';

class CreatorDetailPage extends StatelessWidget {
  CreatorDetailPage({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();

  var eventController = Get.put(EventCreatorController());
  var firstNameNode = FocusNode();
  var lastNameNode = FocusNode();
  var emailNode = FocusNode();
  var businessNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    List<Widget> formFields = [
      GestureDetector(
          onTap: () {
            print("open Gallery");
            eventController.pickImage(context: context);
          },
          child: Obx(
            () => CircleAvatar(
              backgroundColor: Colors.white,
              radius: 55,
              child: eventController.path.isNotEmpty
                  ? CircleAvatar(
                      radius: 55 - 3,
                      backgroundImage:
                          FileImage(File(eventController.path.value ?? "")),
                    )
                  :  Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 55 - 1,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                        backgroundColor: Colors.green, // Customize the color as needed
                        radius: 15,
                        child: Image.asset("assets/images/profile_add.png")
                    ),
                  ),
                ],
              )
            ),
          )),
      SizedBox(
        height: 30,
      ),
      GenericTextField(
        controller: firstNameController,
        hint: AppConstants.enterFirstName,
        label: AppConstants.firstName,
        node: firstNameNode,
      ),
      GenericTextField(
        controller: lastNameController,
        hint: AppConstants.enterLastName,
        label: AppConstants.lastName,
        node: lastNameNode,
      ),
      GenericTextField(
        controller: emailIdController,
        hint: AppConstants.enterEmailId,
        label: AppConstants.emailID,
        node: emailNode,
      ),
      GenericTextField(
        controller: businessNameController,
        hint: AppConstants.enterName,
        label: AppConstants.businessName,
        node: businessNode,
      ),
      Container(
          margin: EdgeInsets.only(left: 15),
          child: Text("Add More Images",style: TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.montserrat,
              fontSize: 12
          ),)),
      SizedBox(height: 8,),
      //grid
      Obx(
            () => eventController.selectedImages.isNotEmpty
            ? Container(
              margin: EdgeInsets.only(left: 15),
          height: 150,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            padding: EdgeInsets.all(4.0),
            children: List.generate(
              eventController.selectedImages.length,
                  (index) => InkWell(
                onTap: () {
                  if (eventController.selectedImages.length > 4) {
                    Fluttertoast.showToast(
                        msg: "You have reached maximum limit");
                  } else {
                    eventController.pickImageFromGallery(context);
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
                                          eventController.selectedImages.remove(eventController.selectedImages[index]);
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
                                File(eventController
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
              if (eventController.selectedImages.length > 4) {
                Fluttertoast.showToast(
                    msg: "You have reached maximum limit");
              } else {
                eventController.pickImageFromGallery(context);
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

    bool isValidEmail(String email) {
      // Define a regular expression for a valid email address
      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

      return emailRegex.hasMatch(email);
    }

    bool validate() {
      if (firstNameController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter firstName");
        return false;
      } else if (lastNameController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter lastName");

        return false;
      }
      else if (eventController.path.isEmpty) {
        Fluttertoast.showToast(msg: "Please Upload Profile Image");

        return false;
      }

      else if (emailIdController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter email");

        return false;
      } else if (businessNameController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter Business name");
        return false;
      } else if (eventController.selectedImages.isEmpty) {
        Fluttertoast.showToast(msg: "Please upload Image");
        return false;
      }
      else {
        return true;
      }
    }

    return SafeArea(
        child: Scaffold(
      body: KeyboardActions(
        config: KeyboardActionsConfig(
            actions: [
              KeyboardActionsItem(focusNode: firstNameNode),
              KeyboardActionsItem(focusNode: lastNameNode),
              KeyboardActionsItem(focusNode: emailNode),
              KeyboardActionsItem(focusNode: businessNode),
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
            child: Stack(children: [
              BlurBackground(
                blurAmount: 10.0,
                borderRadius: 20.0,
                padding: 16.0,
                imagePath: 'assets/images/splash_logo.png',
                belowMargin: MediaQuery.of(context).size.height * 0.13,
                aboveMargin: 97,
                onPressed: () {},
                child: Column(
                  children: [
                    const SizedBox(
                      height: 145,
                    ),

                    ///general details
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.profileCreation,
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
                      padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppConstants.enterYourBusinessDetails,
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
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: AppComponents.createButton("Save", () {
                        if (validate()) {
                          if (isValidEmail(emailIdController.text)) {
                            List<ImageUrl> images = [];
                            images.add(ImageUrl(
                                url: "/766bd30b0abcb17db2352fc26e706fae.png"));

                            eventController.createProfile(CreateProfileRequest(
                                profile_pic: eventController.profilePicPath.value,
                                firstname: firstNameController.text,
                                lastname: lastNameController.text,
                                business_name: businessNameController.text,
                                email: emailIdController.text,
                                country: "india",
                                city: "delhi",
                                images: eventController.imageList));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please enter valid email");
                          }
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
            ]),
          ),
        ),
      ),
    ));
  }
}
