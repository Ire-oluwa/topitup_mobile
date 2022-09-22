import 'dart:convert';

import '../../../constants/api_endpoints.dart';
import '../network_helper.dart';

class TransactionHistoryApi {
  static Future<dynamic> rechargeHistory({
     String? mainService,
    required String apiKey,
    required String deviceId,
  }) async {
    final responseData = await NetworkHelper.postRequest(
      url: BaseUrl.getBaseUrl + EndpointDirectory.endpoint,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          'cmd': 'view_recharge_history',
          'start': 0,
          'length': 100,
          'main_service': mainService,
          'api_key': apiKey,
          'device_id': deviceId,
        },
      ),
    );
    return responseData;
  }
}
