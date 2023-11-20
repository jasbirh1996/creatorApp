import 'dart:io';

import 'package:creator/onBoarding/controller/Restuarant2Controller.dart';
import 'package:creator/onBoarding/controller/ResturantDetailController.dart';
import 'package:creator/onBoarding/view/LoginScreen.dart';
import 'package:creator/onBoarding/view/Restuarent3DetailPage.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:creator/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppFonts.dart';
import '../../utils/BlurBackground.dart';
import '../../utils/GenericTextField.dart';
import '../../utils/TextLabels.dart';

class ResturentDetailPage extends StatefulWidget {
  ResturentDetailPage({super.key});

  @override
  State<ResturentDetailPage> createState() => _ResturentDetailPageState();
}

class _ResturentDetailPageState extends State<ResturentDetailPage> {
  //RestaurantController controller = Get.put(RestaurantController());
  TextEditingController ownerFirstNameCon = TextEditingController();
  TextEditingController ownerLastNameCon = TextEditingController();
  TextEditingController restaurantNameCon = TextEditingController();
  TextEditingController businessEmailIDCon = TextEditingController();
  TextEditingController businessWebsiteCon = TextEditingController();
  TextEditingController addressRestaurantCon = TextEditingController();
  TextEditingController businessDescCon = TextEditingController();
  var controller = Get.put(ResturentDetailController());
  var controller2 = Get.put(Restuarant2Controller());

  var ownerFirstNameNode = FocusNode();
  var ownerLasNameNode = FocusNode();
  var restaurentNameNode = FocusNode();
  var businessEmailNode = FocusNode();
  var businessWebNode = FocusNode();
  var addNode = FocusNode();
  var businessDescriptionNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isValidEmail(String email) {
      // Define a regular expression for a valid email address
      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

      return emailRegex.hasMatch(email);
    }

    bool validate() {
      if (ownerFirstNameCon.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter Owner Name");
        return false;
      } else if (ownerLastNameCon.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter LastName");

        return false;
      } else if (controller.path.value.isEmpty) {
        Fluttertoast.showToast(msg: "Please Upload Image");

        return false;
      }
      else if (restaurantNameCon.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter Business name");

        return false;
      } else if (businessEmailIDCon.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter Email id");
        return false;
      } else if (businessDescCon.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter Business Description");
        return false;
      } else {
        return true;
      }
    }

    List<Widget> formFields = [
      GestureDetector(
          onTap: () {
            print("open Gallery");

            controller.pickImage(context: context);
          },
          child: Obx(
            () => CircleAvatar(
              backgroundColor: Colors.white,
              radius: 55,
              child: controller.path.isNotEmpty
                  ? CircleAvatar(
                      radius: 55 - 3,
                      backgroundImage:
                          FileImage(File(controller.path.value ?? "")),
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
      const SizedBox(
        height: 30,
      ),

      GenericTextField(
        controller: ownerFirstNameCon,
        hint: AppConstants.enterFirstName,
        label: AppConstants.ownerFirstName,
        node: ownerFirstNameNode,
      ),
      GenericTextField(
        controller: ownerLastNameCon,
        hint: AppConstants.enterLastName,
        label: AppConstants.ownerLastName,
        node: ownerLasNameNode,
      ),
      GenericTextField(
        controller: restaurantNameCon,
        hint: AppConstants.enterName,
        label: AppConstants.restaurantName,
        node: restaurentNameNode,
      ),
      GenericTextField(
        controller: businessEmailIDCon,
        hint: AppConstants.enterEmailId,
        label: AppConstants.businessEmailId,
        node: businessEmailNode,
      ),
      GenericTextField(
        controller: businessWebsiteCon,
        hint: AppConstants.enterWebsite,
        label: AppConstants.businessWebsite,
        node: businessWebNode,
      ),
      Obx(
        () => GenericTextField(
          controller: addressRestaurantCon,
          hint: controller.mapLocation.value.isEmpty
              ? AppConstants.enterAddress
              : controller.mapLocation.value,
          label: AppConstants.addressRestaurant,
          model: AppConstants.generalDetails,
          textInputType: TextInputType.text,
          node: addNode,
        ),
      ),


     Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         const TextLabels(
           label: AppConstants.businessDesc,
         ),
         SizedBox(height: 16,),
         Container(
             height: 100,
             margin: EdgeInsets.only(left: 16,right: 16),

             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5.0),
               border: Border.all(color: Colors.grey, width: 0.5),
               color: Colors.transparent,
               boxShadow: const [
                 BoxShadow(
                   color: Colors.grey,
                   offset: Offset(0, -1.5),
                   blurRadius: 1.5,
                 ),
               ],
             ),// Set the desired height
             child: Container(
               color: AppColors.black.withOpacity(0.8),
               child:   TextField(
                 focusNode : businessDescriptionNode,
                 controller: businessDescCon,


                 style:  TextStyle(
                     color: Colors.white,
                     fontFamily: AppFonts.montserrat,
                     fontSize: 12),
                 minLines: 5, // Minimum number of lines
                 maxLines: null, // Unlimited number of lines
                 decoration: const InputDecoration(
                   hintStyle: TextStyle(color: Colors.white),
                   // hintText:  "${controller.myProfile.about}", // Placeholder text
                   hintText:  "Type here.", // Placeholder text
                   border: OutlineInputBorder(), // Optional border decoration
                 ),


               ),
             )
         ),
       ],
     )

      /*GenericTextField(
        controller: businessDescCon,
        hint: AppConstants.typeHere,
        label: AppConstants.businessDesc,
      ),*/
    ];

    return SafeArea(
        child: Scaffold(
      body: KeyboardActions(
        config: KeyboardActionsConfig(
          actions: [
            KeyboardActionsItem(focusNode: ownerFirstNameNode),
            KeyboardActionsItem(focusNode: ownerLasNameNode),
            KeyboardActionsItem(focusNode: restaurentNameNode),
            KeyboardActionsItem(focusNode: businessEmailNode),
            KeyboardActionsItem(focusNode: addNode),
            KeyboardActionsItem(focusNode: businessDescriptionNode)




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
                  aboveMargin: 97,
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
                        padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 0),
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
                      const SizedBox(
                        height: AppUtils.averageSize,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: AppComponents.createButton("Continue", () {
                          if (validate()) {

                            addressRestaurantCon.text =
                                controller.mapLocation.value;
                            if (isValidEmail(businessEmailIDCon.text)) {

                              controller2.profileImage = controller.path.value;
                              controller2.owfirstName = ownerFirstNameCon.text;
                              controller2.owLastName = ownerLastNameCon.text;
                              controller2.businessName = restaurantNameCon.text;
                              controller2.businessEmail = businessEmailIDCon.text;
                              controller2.bussWeb = businessWebsiteCon.text;
                              controller2.address = addressRestaurantCon.text;
                              controller2.busnessDescription = businessDescCon.text;






                              Get.to(ResturentDetailPage3());
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please Enter Valid Email");
                            }
                          }
                        }),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
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
          ),
        ),
      ),
    ));
  }
}
