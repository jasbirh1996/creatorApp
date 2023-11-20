import 'package:flutter/cupertino.dart';

import 'AppColor.dart';
import 'AppFonts.dart';

class TextLabels extends StatelessWidget {
  final String label;
  final String? model;

  const TextLabels(
      {Key? key, required this.label, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
      ),
      child: RichText(
        text: TextSpan(
            text: label,
            style: const TextStyle(
                color: AppColors.white,
                fontFamily: AppFonts.montserrat,
                fontSize:  12),
            children: [
            ]),
      ),
    );
  }
}