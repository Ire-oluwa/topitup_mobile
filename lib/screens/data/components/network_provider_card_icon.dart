import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkProviderCardIcon extends StatelessWidget {
  const NetworkProviderCardIcon({
    Key? key,
    required this.networkProviderLogo,
    required this.onPressed,
  }) : super(key: key);

  final String networkProviderLogo;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            3.w,
          ),
          child: Image.asset(
            networkProviderLogo,
            width: 55.w,
            height: 55.h,
          ),
        ),
      ),
    );
  }
}
