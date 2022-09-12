import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_constants.dart';
import '../../components/custom_text.dart';

class ServiceTypeCard extends StatelessWidget {
  const ServiceTypeCard({
    Key? key,
    required this.label,
    required this.onPressed, required this.backgroundColour, required this.labelColour,
  }) : super(key: key);

  final String label;
  final Color backgroundColour, labelColour;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 150.w,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          color: backgroundColour,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding.w * 2,
              vertical: kDefaultPadding.h + 2,
            ),
            child: CustomText(
              text: label,
              textSize: 15.0.sp,
              textColor: labelColour,
              alignText: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
