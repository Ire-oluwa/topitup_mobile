import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

import '../../constants/app_constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColour,
    required this.borderColour,
    required this.textColour,
    this.textLabelSize,
    this.fontWeight,
    this.textlabelAlignment,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final Color textColour, backgroundColour, borderColour;
  final double? textLabelSize;
  final FontWeight? fontWeight;
  final TextAlign? textlabelAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65.0.h,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: textColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: kLightBorderSide.copyWith(
            color: borderColour,
          ),
          backgroundColor: backgroundColour,
        ),
        child: CustomText(
          text: text,
          fontWeight: fontWeight,
          textSize: textLabelSize,
          alignText: textlabelAlignment,
        ),
      ),
    );
  }
}
