import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/AppColor.dart';
import '../../utils/AppConstants.dart';
import '../../utils/TextLabels.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final String label;
  final String? model;


  CustomDropdown({required this.items, required this.selectedValue,
    required this.onChanged, required this.label, this.model});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabels(label: widget.label),

        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 10, bottom: 20, right: 20),
          child: Container(
            width: widget.model == AppConstants.detailsPage2 ?
            Get.width : Get.width / 3,
            height: 48,
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
            ),
            child: Container(
              height: 48,
              color: AppColors.black.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: widget.selectedValue,
                    dropdownColor: Colors.grey,

                    onChanged: (newValue) {
                      setState(() {
                        widget.onChanged(newValue!);
                      });
                    },
                    style: const TextStyle(
                      color: AppColors.grey,
                    ),
                    icon: Transform.rotate(
                      angle: 90 * 3.1416 / 180,
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.grey,
                      ),
                    ),
                    iconDisabledColor: Colors.grey,
                    elevation: 5,
                    items: widget.items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [



                            Text(value,
                              style: TextStyle(
                                color: widget.selectedValue == value
                                    ? Colors.white // Change the selected item text color
                                    : Colors.white,
                              ),

                            )

                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}