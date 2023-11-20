import 'package:creator/dashBoard/restuarent/RestuarentDashBoard.dart';
import 'package:creator/utils/AppComponents.dart';
import 'package:creator/utils/AppFonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestAccepted extends StatelessWidget {
  const RequestAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
            Align(
              alignment: Alignment.center,
                child: Image.asset(
              "assets/images/request_accept.png",
              width: 146,
              height: 185,
            )),
            SizedBox(height: 50,),
            Text("Request Accepted",style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: AppFonts.montserratBold
            ),),
            SizedBox(height: 12,),
            Text("Your request has been accepted by the\n admin",
                textAlign: TextAlign.center
                ,style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: AppFonts.montserratRegular
            ),),
            SizedBox(height: 50,),
            Container(
              margin: EdgeInsets.only(left: 36,right: 36),
              child: AppComponents.createButton("Go To Home Page", () {
                Get.to(RestaurantDashBoard());
              }),
            )
          ],
        ),
      ),
    );
  }
}
