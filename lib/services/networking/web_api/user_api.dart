import 'dart:convert';

import '../../../constants/api_endpoints.dart';
import '../network_helper.dart';

class UserApi {
  static Future<dynamic> loginUser({
    required String userName,
    required String password,
    required String deviceId,
  }) async {
    final responseData = await NetworkHelper.postRequest(
      url: BaseUrl.getBaseUrl + EndpointDirectory.endpoint,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'cmd': 'login',
          'l_username': userName,
          'l_password': password,
          'device_id': deviceId,
        },
      ),
    );
    return responseData;
  }

  static Future<dynamic> createUser({
    required String deviceId,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
  }) {
    final responseData = NetworkHelper.postRequest(
      url: BaseUrl.getBaseUrl + EndpointDirectory.endpoint,
      body: jsonEncode(
        <String, String>{
          'cmd': 'createAcct',
          'device_id': deviceId,
          'username': username,
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'pass_confirmation': password,
          'phone': phoneNumber,
          'country': '160',
        },
      ),
    );
    return responseData;
  }
}
