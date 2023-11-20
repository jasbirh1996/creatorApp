import 'package:creator/utils/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppFonts.dart';
import 'AppUtils.dart';

class AppComponents {
 static Widget getTransparentButton(String text,VoidCallback onPressedCallback) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onPressedCallback,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            border: Border.all(color: AppColors.carrotRed),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Center(
            child: Text(
              '$text',
              style: TextStyle(color: AppColors.carrotRed,fontSize: 14,fontFamily: AppFonts.montserratSemibold),
            ),
          ),
        ),
      ),
    );
  }

 static Widget createButton(String text, VoidCallback onPressedCallback) {
   return Container(
     height: 50,
     decoration: BoxDecoration(
       gradient: AppUtils.buttonGradient,
       borderRadius: BorderRadius.circular(8.0),
     ),
     child: ElevatedButton(
       onPressed: onPressedCallback,
       style: ElevatedButton.styleFrom(
         primary: Colors.transparent,
         onPrimary: Colors.transparent,
         elevation: 4,
       ),
       child: Container(
         child: Center(
           child: Text(
             text,
             style: const TextStyle(
                 color: Colors.white,
                 fontFamily: AppFonts.montserratSemibold,
                 fontSize: 14),
           ),
         ),
       ),
     ),
   );
 }


  static Widget textWithRegular(String text, double size,
      {Color color = Colors.white}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: AppFonts.montserratRegular,  fontSize: size, color: color),
      softWrap: true,
    );
  }

  static Widget textWithSemiBold(String text, double size,
      {Color color = Colors.white}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: AppFonts.montserrat, fontSize: size, color: color),
      softWrap: true,

    );
  }

  static Widget textWithBold(String text, double size,
      {Color color = Colors.white}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: AppFonts.montserratBold,
          fontSize: size,
          color: color,
      )

    );
  }
  static Widget backButton(){
   return   Row(
     children: [
       Image.asset("assets/images/back.png",
       width: 30,height: 25,),

       Text(
         "Back",
         style: TextStyle(
             color: AppColors.carrotRed

         ),

       ),
     ],
   );
  }
}
