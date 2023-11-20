import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/AppColor.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedDays = <String>[].obs;

  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
}




class DropdownWidget extends StatelessWidget {
  final DropdownController controller = Get.put(DropdownController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown with Checkbox'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 200,
          child: Column(
            children: [
              SizedBox(
                height: 200, // Set your desired constant height
                child: ListView.builder(
                  itemCount: (controller.days.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    int startIndex = index * 2;
                    int endIndex = (index + 1) * 2;
                    endIndex = endIndex > controller.days.length
                        ? controller.days.length
                        : endIndex;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        endIndex - startIndex,
                            (i) {
                          final day = controller.days[startIndex + i];
                          final isSelected =
                          controller.selectedDays.contains(day);

                          return Row(
                            children: [
                              Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedDays.contains(day)
                                        ? controller.selectedDays.remove(day)
                                        : controller.selectedDays.add(day);
                                  }
                                },
                              ),
                              Text(day),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
