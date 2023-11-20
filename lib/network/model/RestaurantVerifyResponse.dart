import 'UserDetails.dart';

/// message : "OTP verified successfully"
/// userDetails : {"OTP":"123456","country_code":"+91","mobile_number":"7506026861","device_type":"N/A","device_token":"N/A","userType":0,"is_blocked":false,"is_profile_created":false,"profile_pic":"","firstname":"","lastname":"","business_name":"","email":"","restaurant_website":"","country":"","city":"","restaurant_address":"","restaurant_description":"","restaurant_working_since":0,"restaurant_runing_days":[],"restaurant_opening_from":"","restaurant_opening_to":"","restaurant_tags":"","is_active":true,"added_on":1698498339,"_id":"653d0723ee53d14870a3af22","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb3VudHJ5X2NvZGUiOiIrOTEiLCJtb2JpbGVfbnVtYmVyIjoiNzUwNjAyNjg2MSIsImlhdCI6MTY5ODU1OTcwMX0.SHdnvffELhwZMC4MLx9XRphL1ThCddo17GfbMsqhCGU","images":[]}


class RestaurantVerifyResponse {
  RestaurantVerifyResponse({
      this.message,
      this.response,
     this.userDetails,

  });

  RestaurantVerifyResponse.fromJson(dynamic json) {
    message = json['message'];
    response = json['response'];
    userDetails =UserDetails.fromJson(json['userDetails']);

  }
  String? message;
  String? response;
  UserDetails? userDetails;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
      map['response'] = response;
    map['userDetails'] = userDetails;
    return map;
  }

}
