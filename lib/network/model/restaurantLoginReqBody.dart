


class RestaurantLoginReqBody {
  String? country_code;
  String? mobileNumber;
  RestaurantLoginReqBody({
     this.country_code,
     this.mobileNumber,
});


  RestaurantLoginReqBody.fromJson(dynamic json) {
    country_code = json['country_code'];
    mobileNumber = json['mobile_number'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_code'] = country_code;
    map['mobile_number'] = mobileNumber;
    return map;
  }

}