import 'dart:convert';

import 'package:topitup/constants/api_endpoints.dart';
import 'package:topitup/services/networking/network_helper.dart';

class WalletBalanceApi {
  static Future<dynamic> getWalletBance({
    required String apiKey,
    required String deviceId,
  }) async {
    final responseData = await NetworkHelper.postRequest(
      url: BaseUrl.getBaseUrl + EndpointDirectory.endpoint,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'cmd': 'balance',
          'api_key': apiKey,
          'device_id': deviceId,
        },
      ),
    );
    return responseData;
  }
}
