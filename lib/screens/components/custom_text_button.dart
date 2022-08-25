import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColour,
    required this.borderColour,
    required this.textColour,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final Color textColour, backgroundColour, borderColour;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0.h,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: kLightBorderSide.copyWith(
            color: borderColour,
          ),
          backgroundColor: backgroundColour,
          primary: textColour,
        ),
        child: Text(text),
      ),
    );
  }
}
