import 'package:flutter/material.dart';

class DeviceInfo with ChangeNotifier {
  String _deviceId = '';

  String get getDeviceId {
    return _deviceId;
  }

  set deviceId(String deviceId) {
    _deviceId = deviceId;
  }
}
