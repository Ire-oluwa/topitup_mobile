import 'dart:convert';

import '../../../constants/api_endpoints.dart';
import '../network_helper.dart';

class ElectricityApi {
  static Future<dynamic> getMainServices({
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
          'cmd': 'get_main_services',
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

  static Future<dynamic> verifyCustomer({
    required String meterNumber,
    required String productCode,
    required String apiKey,
  }) async {
    final responseData = await NetworkHelper.postRequest(
      url:
          '${BaseUrl.getBaseUrl}/api/v2/electric/?api_key=$apiKey&meter_number=$meterNumber&product_code=$productCode&task=verify',
    );
    return responseData;
  }

  static Future<dynamic> buyElectricToken({
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
          'cmd': 'electric',
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
