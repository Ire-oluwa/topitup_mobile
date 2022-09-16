import 'dart:convert';

import 'package:topitup/constants/api_endpoints.dart';
import 'package:topitup/services/networking/network_helper.dart';

class CableApi {
  static Future<dynamic> getSubServices({
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
          'service_code': 'cable_subscription',
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

  static Future<dynamic> buyTvSubscription({
    required String productCode,
    required String recipientCardNumber,
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
          'cmd': 'tv',
          'product_code': productCode,
          'recipient_account_phone_iud': recipientCardNumber,
          'order_amount': orderAmount,
          'api_key': apiKey,
          'device_id': deviceId,
        },
      ),
    );
    return responseData;
  }
}
