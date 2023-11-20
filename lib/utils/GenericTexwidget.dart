import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'AppColor.dart';
import 'AppConstants.dart';
import 'AppFonts.dart';
import 'TextLabels.dart';

class GenericTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint, label;
  final bool widthMatchParent;

  //final bool isMandatory;
  final String? model;
  final bool enabled;

  final Function(String data)? onSubmit;
  final TextInputType textInputType;
  final bool showDescriptionBox;
  final int maxLength;
  final double genricHeight;

  const GenericTextWidget(
      {Key? key,
        required this.controller,
        required this.hint,
        required this.label,
        //required this.isMandatory,
        this.model,
        this.enabled = true,
        this.showDescriptionBox = false,
        this.maxLength = 500,
        this.textInputType = TextInputType.text,
        this.onSubmit,
        this.widthMatchParent = true,
        this.genricHeight = 48})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == AppConstants.businessWebsite
            ? Container(
          margin: EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Text(
                "Business Website ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12, fontFamily: AppFonts.montserrat),
              ),
              Text(
                "(if any)",
                style: TextStyle(
                    color: AppColors.carrotRed,
                    fontSize: 12,
                    fontFamily: AppFonts.montserrat),
              )
            ],
          ),
        )
            : TextLabels(
          label: label,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 11.0, bottom: 20.0),
          child: Card(
            elevation: 6,
            color: AppColors.shadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Set border radius
            ),
            shadowColor: AppColors.shadow.withOpacity(0.3),
            child: Container(
              width: widthMatchParent ? Get.width : Get.width / 3,
              height: genricHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    offset: Offset(0, -1.5),
                    blurRadius: 1.5,
                  ),
                ],
              ),
              child:
              TextField(
                  controller: controller,
                  keyboardType: textInputType,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  enabled: false,
                  readOnly: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.montserrat,
                      fontSize: 12),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColors.shadow, width: 0.002),
                    ),
                    hintText: hint,
                    suffixIcon: model == AppConstants.generalDetails
                        ? InkWell(
                      onTap: () {

                      },
                      child: Icon(
                        Icons.my_location,
                        color: AppColors.carrotRed,
                      ),
                    )
                        : null,
                    alignLabelWithHint: false,
                    hintStyle: const TextStyle(
                        color: AppColors.grey, fontFamily: AppFonts.montserrat),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    fillColor: AppColors.black.withOpacity(0.8),
                    filled: true,
                  ),
                  inputFormatters: textInputType == TextInputType.number
                      ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ]
                      : [
                    FilteringTextInputFormatter.allow(
                        RegExp('[ A-Za-z0-9_@./#&]'))
                  ]),

            ),
          ),
        ),
      ],
    );
  }
}