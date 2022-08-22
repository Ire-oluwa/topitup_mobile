import 'dart:async';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String id = 'splash screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/Topitup.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.id,
        (route) => false,
      ),
    );
    super.initState();
  }
}
