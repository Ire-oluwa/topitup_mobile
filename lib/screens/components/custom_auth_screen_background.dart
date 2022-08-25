import 'package:flutter/material.dart';

class CustomAuthScreenBackground extends StatelessWidget {
  const CustomAuthScreenBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
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
