import 'package:chat_app/controllers/appwrite_controllers.dart';
import 'package:chat_app/models/user_data.dart';
import 'package:flutter/material.dart';

import '../controllers/local_saved_data.dart';

class UserDataProvider extends ChangeNotifier {
  String _userID = "";
  String _username = "";
  String _profilePicture = "";
  String _phoneNumber = "";
  String _deviceToken = "";

  String get getUserID => _userID;
  String get getUsername => _username;
  String get getProfilePicture => _profilePicture;
  String get getPhoneNumber => _phoneNumber;
  String get getDeviceToken => _deviceToken;

  // load data from local database (device)
  void loadDataFromLocalDB() {
    _userID = LocalSavedData.getUserID();
    _username = LocalSavedData.getUserName();
    _profilePicture = LocalSavedData.getUserProfilePicture();
    _phoneNumber = LocalSavedData.getPhoneNumber();
    debugPrint(
        "Loaded data from local DB successfully: $_username, $_phoneNumber, $_userID");
    notifyListeners();
  }

  // load data from appwrite
  void loadUserData(String userID) async {
    UserData? userData = await getUserDetails(userID: userID);
    if (userData != null) {
      _username = userData.name ?? "";
      _profilePicture = userData.profilePicture ?? "";
      notifyListeners();
    }
  }

  // set user id
  void setUserID(String id) {
    _userID = id;
    LocalSavedData.saveUserID(id);
    notifyListeners();
  }

  // set phone
  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
    LocalSavedData.savePhoneNumber(phone);
    notifyListeners();
  }

  // set user name
  void setUserName(String name) {
    _username = name;
    LocalSavedData.saveUserName(name);
    notifyListeners();
  }

  // set profile picture
  void setProfilePicture(String picture) {
    _profilePicture = picture;
    LocalSavedData.saveUserProfilePicture(picture);
    notifyListeners();
  }

  // set device token
  void setDeviceToken(String token) {
    _deviceToken = token;
    notifyListeners();
  }
}
