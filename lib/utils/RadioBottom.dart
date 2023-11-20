import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../onBoarding/controller/CommonController.dart';
import 'AppColor.dart';
import 'AppFonts.dart';

class RadioBottomSheet extends StatefulWidget {
  final List<String> options;
  final String heading;
  final Function(String) onItemSelected;

  RadioBottomSheet({
    required this.options,
    required this.onItemSelected,
    required this.heading,
  });

  @override
  _radioState createState() => _radioState();
}

class _radioState extends State<RadioBottomSheet> {
  String? selectedOption;
  var controller = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.heading}',
              style: const TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.montserratRegular,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Container(
              margin: EdgeInsets.only(left: 2, right: 2),
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
                child: Center(
                  child: InkWell(
                    onTap: () {
                      _showOptions(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Obx(
                          () => controller.selectedRadio.isNotEmpty
                              ? Text(
                                  "${controller.selectedRadio.value}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.montserratMedium,
                                  ),
                                )
                              : Text(
                                  'Select an Option',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: AppFonts.montserratMedium,
                                  ),
                                ),
                        )),
                        Transform.rotate(
                          angle: 90 * 3.1416 / 180,
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Container(
                margin: EdgeInsets.only(bottom: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: 200, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: widget.options.length,
                        itemBuilder: (context, index) {
                          final option = widget.options[index];
                          return Column(
                            children: [
                              RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                activeColor: AppColors.carrotRed,
                                groupValue: selectedOption,
                                onChanged: (String? value) {
                                  setState(() {
                                    controller.selectedRadio.value = value.toString();
                                    selectedOption = value;
                                    widget.onItemSelected(value!);
                                  });
                                },
                              ),
                              Divider()
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(),

                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 48,
                        color: AppColors.carrotRed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: const Text(
                                "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.montserratRegular,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.montserratRegular,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(""),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
