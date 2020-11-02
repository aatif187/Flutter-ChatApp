import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String SharedPreferncesUserLoggedInKey = "ISLOGGEDIN";
  static String SharedPreferncesUsernameKey = "USERNAMEKEY";
  static String SharedPreferncesEmailKey = "EMAILKEY";

//saving data to shared preferences
  static Future<void> saveUserLoggedInsharedpreferneces(
      bool IsUserloggedIN) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(SharedPreferncesUserLoggedInKey, IsUserloggedIN);
  }

  static Future<void> saveUserNamesharedpreferneces(String UserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(SharedPreferncesUsernameKey, UserName);
  }

  static Future<void> saveUserEmailsharedpreferneces(String UserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(SharedPreferncesEmailKey, UserEmail);
  }

  //getting data from shared preferences
  static Future<bool> getUserLoggedInsharedpreferneces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferncesUserLoggedInKey);
  }

  static Future<String> getUserNamesharedpreferneces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferncesUsernameKey);
  }

  static Future<String> getUserEmailsharedpreferneces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferncesEmailKey);
  }
}
