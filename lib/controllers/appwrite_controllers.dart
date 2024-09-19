import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('66eb8ce70034f193b859')
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development

const String db = "66eb8eab002553fe6ec3";
const String userCollection = "66eb8ec20027cb6223f8";

// initializa database stuff
Account account = Account(client);
Databases databases = Databases(client);

// save phone number to database while creating new account
Future<bool> savePhoneToDB({
  required String phoneNumber,
  required String userID,
}) async {
  try {
    // create a new document in the user collection
    final response = await databases.createDocument(
      databaseId: db,
      collectionId: userCollection,
      documentId: userID,
      data: {
        "phone_no": phoneNumber,
        "userID": userID,
      },
    );
    print(response);
    return true;
  } on AppwriteException catch (e) {
    print("database creation failed: $e");
    return false;
  }
}

// check if phone number exists
Future<String> checkPhoneNumber({required String phoneNumber}) async {
  try {
    final DocumentList matchUser = await databases.listDocuments(
      databaseId: db,
      collectionId: userCollection,
      queries: [Query.equal("phone_no", phoneNumber)],
    );
    if (matchUser.total > 0) {
      final Document user = matchUser.documents[0];
      if (user.data["phone_no"] != null || user.data["phone_no"] != "") {
        return user.data["userID"];
      } else {
        print("user does not exist on this db");
        return "user_not_found";
      }
    } else {
      print("user does not exist on this db");
      return "user_not_found";
    }
  } on AppwriteException catch (e) {
    print("error on reain database: $e");
    return "user_not_found";
  }
}

// create a phone session (sent otp to phone number)
Future<String> createPhoneSession({
  required String phone,
}) async {
  try {
    final userID = await checkPhoneNumber(phoneNumber: phone);
    if (userID == "user_not_found") {
      final Token data = await account.createPhoneToken(
        userId: ID.unique(),
        phone: phone,
      );

      // save new user to user collection
      savePhoneToDB(phoneNumber: phone, userID: data.userId);
      return data.userId;

      // if user is an exisiting user
    } else {
      final Token data = await account.createPhoneToken(
        userId: userID,
        phone: phone,
      );
      return data.userId;
    }
  } catch (e) {
    print("error on create phone session: $e");
    return "login_error";
  }
}

// lgo in with otp
Future<bool> loginWithOtp({
  required String otp,
  required String userID,
}) async {
  try {
    final Session session = await account.updatePhoneSession(
      userId: userID,
      secret: otp,
    );
    print(session.userId);
    return true;
  } catch (e) {
    print("error on login with otp: $e");
    return false;
  }
}

// check whether session exists
Future<bool> checkSessions() async {
  try {
    final Session session = await account.getSession(sessionId: "current");
    print("session exists: ${session.$id}");
    return true;
  } catch (e) {
    print("session does not exist");
    return false;
  }
}

// log out user
Future<void> logout() async {
  await account.deleteSession(sessionId: "current");
}
