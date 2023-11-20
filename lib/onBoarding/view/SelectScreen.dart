import 'dart:ui';

import 'package:creator/onBoarding/controller/SelectedController.dart';
import 'package:creator/onBoarding/view/CreatorDetailPage.dart';
import 'package:creator/onBoarding/view/ResturentDetailPage.dart';
import 'package:creator/utils/AppColor.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:creator/utils/AppFonts.dart';
import 'package:creator/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectScreen extends StatelessWidget {
  SelectScreen({super.key});

  var controller = Get.put(SelectedController());
  Widget? widget = ResturentDetailPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_image.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap:(){
                                Get.back();
                              },
                                child: AppComponents.backButton()
                            ),
                          ),
                          Container(
                            child: const Text(
                              "Who you are",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.montserratSemibold,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(""),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              widget = ResturentDetailPage();
                              controller.isSelectedResurent.value = "select";
                              controller.isSelectedCreater.value = "";
                            },
                            child: Obx(
                              () => Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      color: controller
                                              .isSelectedResurent.value.isEmpty
                                          ? AppColors.grey
                                          : AppColors.carrotRed,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -25,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          child: CircleAvatar(
                                            backgroundColor: controller
                                                    .isSelectedResurent
                                                    .value
                                                    .isEmpty
                                                ? AppColors.grey
                                                : AppColors.carrotRed,
                                            child: Image.asset(
                                              controller.isSelectedResurent
                                                      .value.isEmpty
                                                  ? "assets/images/restaurant_inactive.png"
                                                  : "assets/images/restaurant_active.png",
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      // Adjust this value as needed to center the text vertically
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Text(
                                          "Restaurant",
                                          style: TextStyle(
                                              color: controller
                                                      .isSelectedResurent
                                                      .value
                                                      .isEmpty
                                                  ? AppColors.grey
                                                  : AppColors.carrotRed,
                                              fontSize: 16,
                                              fontFamily:
                                                  AppFonts.montserratSemibold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              widget = CreatorDetailPage();
                              controller.isSelectedCreater.value = "select";
                              controller.isSelectedResurent.value = "";
                            },
                            child: Obx(
                              () => Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      color: controller
                                              .isSelectedCreater.value.isEmpty
                                          ? AppColors.grey
                                          : AppColors.carrotRed,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -25,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          child: CircleAvatar(
                                            backgroundColor: controller
                                                    .isSelectedCreater
                                                    .value
                                                    .isEmpty
                                                ? AppColors.grey
                                                : AppColors.carrotRed,
                                            child: Image.asset(
                                              controller.isSelectedCreater.value
                                                      .isEmpty
                                                  ? "assets/images/event_creator_inactive.png"
                                                  : "assets/images/event_creator_active.png",
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      // Adjust this value as needed to center the text vertically
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Text(
                                          "Event Creator",
                                          style: TextStyle(
                                              color: controller
                                                      .isSelectedCreater
                                                      .value
                                                      .isEmpty
                                                  ? AppColors.grey
                                                  : AppColors.carrotRed,
                                              fontSize: 16,
                                              fontFamily:
                                                  AppFonts.montserratSemibold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  AppComponents.createButton("Save", () {
                    if (widget != null) {
                      Get.to(widget);
                    }
                  }),
                  SizedBox(
                    height: AppUtils.averageSize,
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
