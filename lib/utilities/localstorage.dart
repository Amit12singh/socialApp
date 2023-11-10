import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/models/user_model.dart';

class HandleToken {
  // Create storage
  final storage = const FlutterSecureStorage();

  Future<bool> saveAccessToken(user) async {
    const storage = FlutterSecureStorage();

// Write value
    final loggedinUser = UserModel(
      fullName: user['fullName'],
      email: user['email'],
      id: user['id'],
      passedOutYear: user['yearPassedOut'],
      profilePicture: user['profileImage'] != null
          ? ProfilePicture.fromJson(user['profileImage'])
          : null,
    );

    final jsonString = json.encode(loggedinUser.toJson());
   

    try {
      await storage.write(key: 'accessToken', value: user["accessToken"]);
      await storage.write(key: 'user', value: jsonString);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  Future<bool> clearAccessToken() async {
    const storage = FlutterSecureStorage();
    try {
      await storage.delete(key: 'accessToken');
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> isUserLoggedIn() async {
    final token = await storage.read(key: 'accessToken');

    if (token != null) {
      return true;
    }
    return false;
  }

  Future<UserModel?> getUser() async {
    const storage = FlutterSecureStorage();

    String? jsonUser = await storage.read(key: 'user');
    if (jsonUser != null) {
      Map<String, dynamic> userMap = json.decode(jsonUser);
      UserModel user = UserModel.fromJson(userMap);

      return user;
    }
    return null;
  }

  Future<bool> showOnboarding() async {
    final isFirstTime = await storage.read(key: 'isFirstTime');
    if (isFirstTime == 'false') {
      return false;
    } else {
      return true;
    }
  }
}
