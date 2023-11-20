
import 'package:creator/network/model/restuarantLoginData.dart';

/// message : "Please Verify your OTP"
/// data : {"access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb3VudHJ5X2NvZGUiOiIrOTEiLCJtb2JpbGVfbnVtYmVyIjoiOTY2NzkyMzMzNSIsImlhdCI6MTY5ODQ4ODg1MH0.io7gHWxjsrWnsoz4RemIsY5YmBOYjdysc9Gj6cLXJJg","mobile_number":"9667923335","country_code":"+91"}

class RestaurantLoginResponse {
  RestaurantLoginResponse({
     this.data,
     this.message,
});

  RestaurantLoginResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? RestaurantLoginData.fromJson(json['data']) : null;
  }

  String? message;
      RestaurantLoginData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    final data = this.data;
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }

}

