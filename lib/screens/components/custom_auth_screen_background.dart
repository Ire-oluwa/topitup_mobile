import 'package:flutter/material.dart';

class CustomAuthScreenBackground extends StatelessWidget {
  const CustomAuthScreenBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/home_background.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
