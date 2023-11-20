import 'package:creator/onBoarding/controller/TutorialController.dart';
import 'package:creator/onBoarding/view/LoginScreen.dart';
import 'package:creator/onBoarding/view/Splash.dart';
import 'package:creator/routes/AppRoutes.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:creator/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppConstants.dart';
import '../../utils/AppFonts.dart';

class OnBoardingRestuarant extends StatefulWidget {
  const OnBoardingRestuarant({super.key});


  @override
  State<OnBoardingRestuarant> createState() => _OnBoardingRestuarantState();
}

class _OnBoardingRestuarantState extends State<OnBoardingRestuarant> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool showNext = true;
  final PageController _pageControllerText = PageController();

  List<Map<String, String>> onboardingData = [
    {
      'title': AppConstants.onBoardingStep1Title,
      'description': AppConstants.onBoardingStep1Desc,
      'image': 'assets/images/tutorial_image_1.png',
    },
    {
      'title': AppConstants.onBoardingStep2Title,
      'description': AppConstants.onBoardingStep2Desc,
      'image': 'assets/images/tutorial_img_2.png',
    },
    {
      'title': AppConstants.onBoardingStep3Title,
      'description': AppConstants.onBoardingStep3Desc,
      'image': 'assets/images/tutorial_img_3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              color: Colors.black,
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: PageView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (int page) {

                      setState(() {
                        print("page $page");
                        _currentPage = page;
                        _pageControllerText.jumpToPage(page);


                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        onboardingData[index]['image']!,
                        fit: BoxFit.fitWidth,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.46,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    // padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: onboardingData.length,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Colors.orange,
                            dotColor: Colors.grey,
                            dotHeight: 10.0,
                            dotWidth: 10.0,
                          ),
                        ),


                        Expanded(

                          child: PageView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            controller: _pageControllerText,
                            // controller: _pageController,
                            itemCount: onboardingData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: 40,right: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      onboardingData[index]['title']!,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontFamily: AppFonts.montserratBold),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      onboardingData[index]['description']!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(

                                          fontSize: 14.0,
                                          color: AppColors.grey,
                                          fontFamily: AppFonts.montserratMedium),


                                    ),
                                  ],
                                ),
                              );
                            },
                            onPageChanged: (int page) {
                              _pageController.jumpToPage(page);

                              setState(() {
                                print("lower slider $page");
                                _currentPage = page;
                              });
                            },


                          ),
                        ),


                        // Next button
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 20,),
                                Visibility(
                                  visible: _currentPage != 2,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *0.425,
                                    child: AppComponents.getTransparentButton("Skip",(){
                                      Get.to(()=>LoginScreen());
                                      return;
                                    }),
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Expanded(

                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: AppComponents.createButton("Continue", () {



                                      int nextPage = 0;
                                      if (_currentPage < 3) {

                                        nextPage = _currentPage + 1;
                                        print("1 screen");
                                      }
                                      if (_currentPage == 3) {
                                            print("3 screen");
                                      }
                                      if (_currentPage == 2) {
                                        print("2 screen");



                                        setState(() {
                                          showNext = false;
                                          print("next");
                                        });
                                        Get.to(()=>LoginScreen());
                                        return;
                                      }
                                      setState(() {
                                        _currentPage = nextPage;
                                        _pageController.jumpToPage(_currentPage);
                                        _pageControllerText.jumpToPage(_currentPage);
                                      });
                                    },
                                  ),
                                ),
                                ),
                                SizedBox(width: 20,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            )));
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.orange : Colors.grey,
      ),
    );
  }
}