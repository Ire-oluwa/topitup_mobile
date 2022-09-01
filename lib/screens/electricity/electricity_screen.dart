import 'package:flutter/material.dart';

class ElectricityScreen extends StatelessWidget {
  const ElectricityScreen({Key? key}) : super(key: key);

  static const String id = 'electricity screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Electricity'),
      ),
    );
  }
}
