import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_constants.dart';
import 'custom_text.dart';

class CustomTransactionHistoryCard extends StatelessWidget {
  const CustomTransactionHistoryCard({
    Key? key,
    required this.transactionTypeImage,
    required this.transactionTypelabel,
    required this.transactionDate,
    required this.transactionAmount,
    required this.transactionPayStatus,
    required this.transactionStatusColour,
  }) : super(key: key);

  final String transactionTypeImage,
      transactionTypelabel,
      transactionDate,
      transactionAmount,
      transactionPayStatus;
  final Color transactionStatusColour;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              transactionTypeImage,
              width: 30.w,
              height: 30.h,
            ),
            SizedBox(
              width: kDefaultPadding.w - 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.w,
                  child: CustomText(
                    text: transactionTypelabel,
                    fontWeight: FontWeight.w600,
                    textColor: kSecondaryColour,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomText(
                  text: transactionDate,
                  textSize: 12.sp,
                  textColor: const Color(0XFF8A8A8A),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 65.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: transactionAmount,
                    fontWeight: FontWeight.w700,
                    textSize: 13.sp,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  CustomText(
                    text: transactionPayStatus,
                    textColor: transactionStatusColour,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: kDefaultPadding.w + 5,
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: kDefaultIconSize.sp,
            ),
          ],
        ),
      ),
    );
  }
}
