import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppColor.dart';
import 'AppFonts.dart';

class CustomDialog extends StatelessWidget {
  final String image;
  final String gifImage;
  final String label;
  final String description;
  final bool showGif;


  CustomDialog({ required this.image, required this.label,
    required this.description,  required this.gifImage, required this.showGif});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showGif && gifImage != null)
                Image(
                  image: AssetImage(gifImage!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              else if (image != null)
                Image(
                  image: AssetImage(image!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),


              const SizedBox(height: 16),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.montserratBold,
                    color: AppColors.black
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(description,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.montserrat,
                      color: AppColors.grey
                  ),),
              ),
              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}