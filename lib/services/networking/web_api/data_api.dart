import 'dart:convert';

import '../../../constants/api_endpoints.dart';
import '../network_helper.dart';

class DataApi {
  static Future<dynamic> getSubServices({
    required String serviceCode,
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
          'cmd': 'get_sub_services',
          'service_code': serviceCode,
          'api_key': apiKey,
          'device_id': deviceId,
        },
      ),
    );
    return responseData;
  }

  static Future<dynamic> getAvailableServices({
    required String subServiceCode,
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
          'cmd': 'get_available_services',
          'sub_service_code': subServiceCode,
          'api_key': apiKey,
          'device_id': deviceId,
        },
      ),
    );
    return responseData;
  }

    static Future<dynamic> buyAirtime({
    required String productCode,
    required String recipientPhoneNumber,
    required int orderAmount,
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
          'cmd': 'airtime',
          'product_code': productCode,
          'recipient_account_phone_iud': recipientPhoneNumber,
          'order_amount': orderAmount,
          'api_key': apiKey,
          'device_id': deviceId,
        },
      ),
    );
    return responseData;
  }
}
