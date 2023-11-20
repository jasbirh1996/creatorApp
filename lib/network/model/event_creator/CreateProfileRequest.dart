import 'dart:ui';

class CreateProfileRequest {
  String profile_pic;
  String firstname;
  String lastname;
  String business_name;
  String email;
  String country;
  String city;
  List<ImageUrl>? images;

  CreateProfileRequest(
      {required this.profile_pic,
      required this.firstname,
      required this.lastname,
      required this.business_name,
      required this.email,
      required this.country,
      required this.city,
      required this.images});

  Map<String, dynamic> toJson() {
    return {
      "profile_pic": profile_pic,
      "firstname": firstname,
      "lastname": lastname,
      "business_name": business_name,
      "email": email,
      "country": country,
      "city": city,
      "images": images == null
          ? []
          : List<dynamic>.from(images!.map((x) => x.toJson())),
    };
  }

}
class ImageUrl {
  String? url;

  ImageUrl({
    this.url,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}