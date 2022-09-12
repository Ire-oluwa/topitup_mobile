import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_constants.dart';
import '../../components/custom_text.dart';

class CustomDashboardFeatureIconCard extends StatelessWidget {
  const CustomDashboardFeatureIconCard({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final Function() onPressed;
  final String icon, label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.h,
              width: 80.w,
              child: Card(
                elevation: 1,
                shadowColor: kSecondaryColour,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                color: kSecondaryColour,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: kDefaultPadding.w - 5,
                  ),
                  child: SvgPicture.asset(
                    icon,
                    color: Colors.white,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
              ),
            ),
            CustomText(
              text: label,
              fontWeight: FontWeight.w600,
              textSize: 13.sp,
              alignText: TextAlign.center,
            ),
          ],
        ));
  }
}
