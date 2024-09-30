import 'package:shared_preferences/shared_preferences.dart';

class LocalSavedData {
  static SharedPreferences? sharedPreferences;

  // initialize
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // save the userID
  static Future<void> saveUserID(String userID) async {
    await sharedPreferences!.setString('userID', userID);
  }

  // get the userID
  static getUserID() {
    return sharedPreferences!.getString('userID') ?? "";
  }

  // save userName
  static Future<void> saveUserName(String userName) async {
    await sharedPreferences!.setString('name', userName);
  }

  // get user name
  static String getUserName() {
    return sharedPreferences!.getString('name') ?? "";
  }

  // save phone number
  static Future<void> savePhoneNumber(String phoneNumber) async {
    await sharedPreferences!.setString("phone", phoneNumber);
  }

  // get phone number
  static String getPhoneNumber() {
    return sharedPreferences!.getString("phone") ?? "";
  }

  // save user profile picture
  static Future<void> saveUserProfilePicture(String profile) async {
    await sharedPreferences!.setString("profile", profile);
  }

  // get profile picture
  static String getUserProfilePicture() {
    return sharedPreferences!.getString("profile") ?? "";
  }

  static clearData() {
    sharedPreferences!.clear();
    print("cleared data from local DB!");
  }
}
