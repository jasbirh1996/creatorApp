import 'dart:ui';

import 'package:creator/utils/AppColor.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlurBackground extends StatelessWidget {
  final Widget child;
  final double blurAmount;
  final double borderRadius;
  final double padding;
  final String imagePath;
  final double belowMargin;
  final double aboveMargin;
  final bool showBackButton;
  final Function onPressed;

  BlurBackground({
    required this.child,
    this.blurAmount = 10.0,
    this.borderRadius = 20.0,
    this.padding = 16.0,
    required this.imagePath,
    required this.belowMargin,
    required this.aboveMargin,
    this.showBackButton = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_image.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: aboveMargin,
          right: 20.0,
          left: 20.0,
          bottom: belowMargin,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: blurAmount, sigmaX: blurAmount),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: AppColors.grey, // Border color
                    width: 0.5, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Center(
                  child: child,
                ),
              ),
            ),
            /*Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: (){
                  print("tap");
                }, // Update the onTap callback
                child: Container(
                  margin: EdgeInsets.only(left: 0),
                  child: AppComponents.backButton(),
                ),
              ),
            ),*/
            Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 170,
                  height: 180,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

