import 'package:flutter/material.dart';

class ApiKey with ChangeNotifier {
    String _apiKey = '';

  String get getApiKey {
    return _apiKey;
  }

  set apiKey(String apiKey) {
    _apiKey = apiKey;
  }
}