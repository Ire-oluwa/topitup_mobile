import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = 'home screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Topitup NG',
        ),
      ),
      body: const Center(
        child: Text(
          'Topitup Ng',
        ),
      ),
    );
  }
}
