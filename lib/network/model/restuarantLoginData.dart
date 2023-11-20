/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb3VudHJ5X2NvZGUiOiIrOTEiLCJtb2JpbGVfbnVtYmVyIjoiOTY2NzkyMzMzNSIsImlhdCI6MTY5ODQ4ODg1MH0.io7gHWxjsrWnsoz4RemIsY5YmBOYjdysc9Gj6cLXJJg"
/// mobile_number : "9667923335"
/// country_code : "+91"

class RestaurantLoginData {
  RestaurantLoginData({
    this.accessToken,
    this.mobileNumber,
    this.countryCode,});


  RestaurantLoginData.fromJson(dynamic json) {
    accessToken = json['access_token'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
  }
  String? accessToken;
  String? mobileNumber;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['mobile_number'] = mobileNumber;
    map['country_code'] = countryCode;
    return map;
  }

}