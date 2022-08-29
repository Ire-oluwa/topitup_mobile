import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static void setUserApiKey(String apiKey) async {
    await _storage.write(key: 'apiKey', value: apiKey);
  }

  static Future<String?> getUserApiKey() async {
    final value = await _storage.read(key: 'apiKey');
    return value;
  }

  static void deleteUserApiKey() async {
    await _storage.delete(key: 'apiKey');
  }
}
