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

    print('loggedinUser');
    final jsonString = json.encode(loggedinUser.toJson());
    print('jsonString $jsonString');

    try {
      await storage.write(key: 'accessToken', value: user["accessToken"]);
      await storage.write(key: 'user', value: jsonString);
      print('save token try');
      return true;
    } catch (err) {
      print('Error in saveAccessToken: $err');
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'accessToken');
  }

  Future getUser() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'user');
  }
}
