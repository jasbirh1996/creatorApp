

class RestaurantVerifyOtpReqBody {
  RestaurantVerifyOtpReqBody({
    this.otp,
  });

  RestaurantVerifyOtpReqBody.fromJson(dynamic json) {
    otp = json['otp'];
  }
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp'] = otp;
    return map;
  }

}