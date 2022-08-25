import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? textSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign? alignText;
  final TextOverflow? overflow;
  final bool? softwrap;

  const CustomText({
    Key? key,
    required this.text,
    this.textSize,
    this.fontWeight,
    this.textColor,
    this.alignText,
    this.overflow,
    this.softwrap,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: textSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
      textAlign: alignText,
      overflow: overflow,
      softWrap: softwrap,
    );
  }
}
