import 'dart:convert';

RestaurantResponse creatorResponseFromJson(String str) =>
    RestaurantResponse.fromJson(json.decode(str));

String restaurantResponseToJson(RestaurantResponse data) =>
    json.encode(data.toJson());

class RestaurantResponse {
  int? status;
  String? message;

  RestaurantResponse({
    this.status,
    this.message,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
