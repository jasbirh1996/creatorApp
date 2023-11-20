import 'dart:convert';

import 'package:creator/network/model/event_creator/CreateProfileRequest.dart';

RestaurantRequest restaurantRequestFromJson(String str) =>
    RestaurantRequest.fromJson(json.decode(str));

String restaurantRequestToJson(RestaurantRequest data) =>
    json.encode(data.toJson());

class RestaurantRequest {
  String? profilePic;
  String? firstname;
  String? lastname;
  String? businessName;
  String? email;
  String? restaurantWebsite;
  String? restaurantAddress;
  String? restaurantDescription;
  String? restaurantWorkingSince;
  String? restaurantOpeningFrom;
  String? restaurantOpeningTo;
  String? restaurantTags;
  List<ImageUrl>? images;

  RestaurantRequest({
    this.profilePic,
    this.firstname,
    this.lastname,
    this.businessName,
    this.email,
    this.restaurantWebsite,
    this.restaurantAddress,
    this.restaurantDescription,
    this.restaurantWorkingSince,
    this.restaurantOpeningFrom,
    this.restaurantOpeningTo,
    this.restaurantTags,
    this.images,
  });

  factory RestaurantRequest.fromJson(Map<String, dynamic> json) =>
      RestaurantRequest(
        profilePic: json["profile_pic"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        businessName: json["business_name"],
        email: json["email"],
        restaurantWebsite: json["restaurantWebsite"],
        restaurantAddress: json["restaurantAddress"],
        restaurantDescription: json["restaurantDescription"],
        restaurantWorkingSince: json["restaurantWorkingSince"],
        restaurantOpeningFrom: json["restaurantOpeningFrom"],
        restaurantOpeningTo: json["restaurantOpeningTo"],
        restaurantTags: json["restaurantTags"],
        images: json["images"] == null
            ? []
            : List<ImageUrl>.from(json["images"]!.map((x) => ImageUrl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "profile_pic": profilePic,
    "firstname": firstname,
    "lastname": lastname,
    "business_name": businessName,
    "email": email,
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}