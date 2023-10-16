import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/models/user_model.dart';

class HandleToken {
  // Create storage

  Future<bool> saveAccessToken(user) async {
    const storage = FlutterSecureStorage();
    print(user['fullName']);

// Write value
    final loggedinUser = UserModel(
        fullName: user['fullName'], email: user['email'], id: user['id']);

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
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'accessToken');
  }

  Future<bool> clearAccessToken() async {
    final storage = FlutterSecureStorage();
    try {
      await storage.delete(key: 'accessToken');
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<UserModel?> getUser() async {
    const storage = FlutterSecureStorage();

    String? jsonUser = await storage.read(key: 'user');
    if (jsonUser != null) {
      Map<String, dynamic> userMap = json.decode(jsonUser);
      UserModel user = UserModel.fromJson(userMap);

      print('curr user ');
      print(user.id);

      return user;
    }
    return null;
  }
}
