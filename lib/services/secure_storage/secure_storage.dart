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

  static void setLoginUsername(String userName) async {
    await _storage.write(key: 'loginUserName', value: userName);
  }

  static Future<String?> currentLoginUsername() async {
    final value = await _storage.read(key: 'loginUserName');
    return value;
  }

  static void deleteLoginUsername() async {
    await _storage.delete(key: 'loginUserName');
  }

  static void setLoginPassword(String password) async {
    await _storage.write(key: 'loginPassword', value: password);
  }

  static Future<String?> currentLoginPassword() async {
    final value = await _storage.read(key: 'loginPassword');
    return value;
  }

  static void deleteLoginPassword() async {
    await _storage.delete(key: 'loginPassword');
  }
}
