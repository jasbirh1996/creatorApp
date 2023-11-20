class RestaurantCategoryTag {
  int status;
  String message;
  List<Tag> tagList;

  RestaurantCategoryTag({
    required this.status,
    required this.message,
    required this.tagList,
  });

  factory RestaurantCategoryTag.fromJson(Map<String, dynamic> json) {
    List<dynamic> tagListJson = json['taglist'];

    return RestaurantCategoryTag(
      status: json['status'],
      message: json['message'],
      tagList: List<Tag>.from(tagListJson.map((tag) => Tag.fromJson(tag))),
    );
  }
}

class Tag {
  int isDeleted;
  int status;
  int addedOn;
  String id;
  String image;
  String name;

  Tag({
    required this.isDeleted,
    required this.status,
    required this.addedOn,
    required this.id,
    required this.image,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      isDeleted: json['is_deleted'],
      status: json['status'],
      addedOn: json['added_on'],
      id: json['_id'],
      image: json['image'],
      name: json['name'],
    );
  }
}
