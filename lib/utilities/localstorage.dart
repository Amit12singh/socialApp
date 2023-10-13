import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HandleToken {
  // Create storage


  Future<bool> saveAccessToken(String token) async {
    const storage = FlutterSecureStorage();
// Write value
try {
      await storage.write(key: 'accessToken', value: token);
      return true;
    } catch (err) {
      return false;
    }
     
  }

  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'accessToken');
  }
}
