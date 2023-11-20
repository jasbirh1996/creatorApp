
/// OTP : "123456"
/// country_code : "+91"
/// mobile_number : "7506026861"
/// device_type : "N/A"
/// device_token : "N/A"
/// userType : 0
/// is_blocked : false
/// is_profile_created : false
/// profile_pic : ""
/// firstname : ""
/// lastname : ""
/// business_name : ""
/// email : ""
/// restaurant_website : ""
/// country : ""
/// city : ""
/// restaurant_address : ""
/// restaurant_description : ""
/// restaurant_working_since : 0
/// restaurant_runing_days : []
/// restaurant_opening_from : ""
/// restaurant_opening_to : ""
/// restaurant_tags : ""
/// is_active : true
/// added_on : 1698498339
/// _id : "653d0723ee53d14870a3af22"
/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb3VudHJ5X2NvZGUiOiIrOTEiLCJtb2JpbGVfbnVtYmVyIjoiNzUwNjAyNjg2MSIsImlhdCI6MTY5ODU1OTcwMX0.SHdnvffELhwZMC4MLx9XRphL1ThCddo17GfbMsqhCGU"
/// images : []

class UserDetails {
  UserDetails({
    this.otp,
    this.countryCode,
    this.mobileNumber,
    this.deviceType,
    this.deviceToken,
    this.userType,
    this.isBlocked,
    this.isProfileCreated,
    this.profilePic,
    this.firstname,
    this.lastname,
    this.businessName,
    this.email,
    this.restaurantWebsite,
    this.country,
    this.city,
    this.restaurantAddress,
    this.restaurantDescription,
    this.restaurantWorkingSince,
    this.restaurantRuningDays,
    this.restaurantOpeningFrom,
    this.restaurantOpeningTo,
    this.restaurantTags,
    this.isActive,
    this.addedOn,
    this.id,
    this.accessToken,
    this.images,});

  UserDetails.fromJson(dynamic json) {
    otp = json['OTP'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    userType = json['userType'];
    isBlocked = json['is_blocked'];
    isProfileCreated = json['is_profile_created'];
    profilePic = json['profile_pic'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    businessName = json['business_name'];
    email = json['email'];
    restaurantWebsite = json['restaurant_website'];
    country = json['country'];
    city = json['city'];
    restaurantAddress = json['restaurant_address'];
    restaurantDescription = json['restaurant_description'];
    restaurantWorkingSince = json['restaurant_working_since'];
    /*if (json['restaurant_runing_days'] != null) {
      restaurantRuningDays = [];
      json['restaurant_runing_days'].forEach((v) {
        restaurantRuningDays?.add(Dynamic.fromJson(v));
      });
    }*/
    restaurantOpeningFrom = json['restaurant_opening_from'];
    restaurantOpeningTo = json['restaurant_opening_to'];
    restaurantTags = json['restaurant_tags'];
    isActive = json['is_active'];
    addedOn = json['added_on'];
    id = json['_id'];
    accessToken = json['access_token'];
    /*if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Dynamic.fromJson(v));
      });
    }*/
  }
  String? otp;
  String? countryCode;
  String? mobileNumber;
  String? deviceType;
  String? deviceToken;
  num? userType;
  bool? isBlocked;
  bool? isProfileCreated;
  String? profilePic;
  String? firstname;
  String? lastname;
  String? businessName;
  String? email;
  String? restaurantWebsite;
  String? country;
  String? city;
  String? restaurantAddress;
  String? restaurantDescription;
  num? restaurantWorkingSince;
  List<dynamic>? restaurantRuningDays;
  String? restaurantOpeningFrom;
  String? restaurantOpeningTo;
  String? restaurantTags;
  bool? isActive;
  num? addedOn;
  String? id;
  String? accessToken;
  List<dynamic>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OTP'] = otp;
    map['country_code'] = countryCode;
    map['mobile_number'] = mobileNumber;
    map['device_type'] = deviceType;
    map['device_token'] = deviceToken;
    map['userType'] = userType;
    map['is_blocked'] = isBlocked;
    map['is_profile_created'] = isProfileCreated;
    map['profile_pic'] = profilePic;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['business_name'] = businessName;
    map['email'] = email;
    map['restaurant_website'] = restaurantWebsite;
    map['country'] = country;
    map['city'] = city;
    map['restaurant_address'] = restaurantAddress;
    map['restaurant_description'] = restaurantDescription;
    map['restaurant_working_since'] = restaurantWorkingSince;
    if (restaurantRuningDays != null) {
      map['restaurant_runing_days'] = restaurantRuningDays?.map((v) => v.toJson()).toList();
    }
    map['restaurant_opening_from'] = restaurantOpeningFrom;
    map['restaurant_opening_to'] = restaurantOpeningTo;
    map['restaurant_tags'] = restaurantTags;
    map['is_active'] = isActive;
    map['added_on'] = addedOn;
    map['_id'] = id;
    map['access_token'] = accessToken;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}