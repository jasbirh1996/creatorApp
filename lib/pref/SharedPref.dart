import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _accessTokenKey = 'access_token';
  static const String _permissionState = 'is_granted';
  static const String country_code = 'user_id';
  static const String keyUsername = 'username';

  /// Save the access token to shared preferences
  static Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_accessTokenKey, accessToken);
  }

  /// Retrieve the access token from shared preferences
  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }


  static Future<void> savePermissionState(String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_permissionState, state);
  }
  static Future<String?> getPermissionState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_permissionState);
  }


  static Future<void> saveUserDetails(Map<String, dynamic> userDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_accessTokenKey, userDetails['access_token']);
    prefs.setString(country_code, userDetails['userDetails']['country_code']);
    prefs.setString(keyUsername, '${userDetails['userDetails']['firstname']} ${userDetails['userDetails']['lastname']}');
    // Save other user details as needed
  }


  static Future<Map<String, dynamic>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String accessToken = prefs.getString(_accessTokenKey) ?? '';
    String country = prefs.getString(country_code) ?? '';
    String username = prefs.getString(keyUsername) ?? '';
    // Retrieve other user details as needed

    return {
      'access_token': accessToken,
      'country_code': country,
      'username': username,
      // Add other user details as needed
    };
  }


}