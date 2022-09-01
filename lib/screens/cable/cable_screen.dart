import 'package:flutter/material.dart';

class CableScreen extends StatelessWidget {
  const CableScreen({Key? key}) : super(key: key);

  static const String id = 'cable tv screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cable'),
      ),
    );
  }
}
