import 'package:flutter/material.dart';

void main() {
  runApp(
    const TopitupNg(),
  );
}

class TopitupNg extends StatelessWidget {
  const TopitupNg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopitupNG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          'Topitup Ng is cool',
        ),
      ),
    );
  }
}
