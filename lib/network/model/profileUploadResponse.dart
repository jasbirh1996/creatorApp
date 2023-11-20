import 'dart:convert';

ProfileUplaodResponse profileUplaodResponseFromJson(String str) =>
    ProfileUplaodResponse.fromJson(json.decode(str));

String profileUplaodResponseToJson(ProfileUplaodResponse data) =>
    json.encode(data.toJson());

class ProfileUplaodResponse {
  int? status;
  String? message;
  Data? data;

  ProfileUplaodResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileUplaodResponse.fromJson(Map<String, dynamic> json) =>
      ProfileUplaodResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? imageUrl;

  Data({
    this.imageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
      };
}
