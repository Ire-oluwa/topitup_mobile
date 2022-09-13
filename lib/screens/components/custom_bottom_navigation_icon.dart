import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationIcon extends StatelessWidget {
  const CustomBottomNavigationIcon({
    Key? key,
    required this.iconName,
    required this.iconColour,
  }) : super(key: key);

  final String iconName;
  final Color iconColour;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 35.h,
        width: 35.w,
        color: Colors.white,
        padding: EdgeInsets.all(
          5.w,
        ),
        child: SvgPicture.asset(
          iconName,
          color: iconColour,
          width: 18.w,
          height: 18.h,
        ),
      ),
    );
  }
}