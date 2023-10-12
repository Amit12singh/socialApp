import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HandleToken {
  // Create storage

  final storage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
// Write value
    return await storage.write(key: 'accessToken', value: token);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }
}
