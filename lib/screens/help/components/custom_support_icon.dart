import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportIcon extends StatelessWidget {
  const SupportIcon({
    Key? key,
    required this.iconPath,
    required this.onPressed,
  }) : super(key: key);

  final String iconPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        iconPath,
        width: 30.w,
        height: 30.h,
      ),
    );
  }
}
