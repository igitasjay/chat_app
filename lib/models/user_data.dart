class UserData {
  final String? name;
  final String phone;
  final String userID;
  final String? profilePicture;
  final String? deviceToken;
  final bool? isOnline;

  UserData({
    this.name,
    required this.phone,
    required this.userID,
    this.profilePicture,
    required this.deviceToken,
    this.isOnline,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'name': name,
  //     'phone': phone,
  //     'userID': userID,
  //     'profilePicture': profilePicture,
  //     'deviceToken': deviceToken,
  //     'isOnline': isOnline,
  //   };
  // }

  // convert docment data to user data

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      phone: map['phone_no'] != null ? map['phone_no'] as String : "",
      name: map['name'] != null ? map['name'] as String : "",
      userID: map['userID'] as String,
      profilePicture:
          map['profile_pic'] != null ? map['profile_pic'] as String : "",
      deviceToken:
          map['device_token'] != null ? map['device_token'] as String : "",
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserData.fromJson(String source) =>
  //     UserData.fromMap(json.decode(source) as Map<String, dynamic>);
}
