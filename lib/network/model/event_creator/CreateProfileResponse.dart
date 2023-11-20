class CreateProfileResponse {
  int? status;
  String? message;

  CreateProfileResponse({this.status, this.message});

  CreateProfileResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}
