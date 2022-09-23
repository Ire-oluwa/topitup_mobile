import 'dart:async';

import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart';
import '../../services/secure_storage/secure_storage.dart';

import '../../providers/device_info_provider.dart';
import '../home/home_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String id = 'splash screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? _initScreen;
  String _deviceId = '';
  String? _loggedInUsername;
  String? _loggedInPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/splash/Topitup.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    _checkForFirstTimeUser();
    _checkForAlreadyLoggedInUser();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getDeviceId().then((value) {
      _deviceId = value!;
      context.read<DeviceInfo>().deviceId = _deviceId;
    });
    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushNamedAndRemoveUntil(
        _initScreen == 0 || _initScreen == null
            ? OnboardingScreen.id
            : _loggedInUsername != null && _loggedInPassword != null
                ? LoginScreen.id
                : HomeScreen.id,
        (route) => false,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _setFirstTimeUser();
    super.dispose();
  }

  Future<String?> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  void _checkForAlreadyLoggedInUser() async {
    final username = await SecureStorage.currentLoginUsername();
    final password = await SecureStorage.currentLoginPassword();
    setState(() {
      _loggedInUsername = username;
      _loggedInPassword = password;
    });
  }

  void _checkForFirstTimeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _initScreen = preferences.getInt('initScreen');
  }

  void _setFirstTimeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('initScreen', 1);
  }
}
