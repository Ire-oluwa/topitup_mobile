import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/palette.dart';
import '../../components/custom_text.dart';

class DashboardHeaderTransactionDetailsCard extends StatelessWidget {
  const DashboardHeaderTransactionDetailsCard({
    Key? key,
    required this.walletAmount,
    required this.cashbackAmount,
    required this.voucherAmount,
  }) : super(key: key);

  final String walletAmount, cashbackAmount, voucherAmount;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding.w,
          vertical: kDefaultPadding.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kDefaultPadding.h,
            ),
            Padding(
              padding: EdgeInsets.all(
                5.0.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Wallet',
                    textSize: 18.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    textColor: Palette.kCustomColour.shade50,
                  ),
                  CustomText(
                    text: '₦$walletAmount',
                    textSize: 20.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    textColor: kSecondaryColour,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding.h / 2,
              ),
              child: const Divider(
                height: 1.0,
                color: Color(0xFFB7B4B4),
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/naira-icon.svg',
                        width: kDefaultIconSize.w,
                        height: kDefaultIconSize.h,
                      ),
                      const CustomText(
                        text: ' Cashback',
                        fontFamily: 'Montserrat',
                        textColor: Colors.black45,
                      ),
                      const Spacer(),
                      CustomText(text: '₦$cashbackAmount'),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/voucher-icon.svg',
                        width: kDefaultIconSize.w - 5,
                        height: kDefaultIconSize.h - 5,
                      ),
                      const CustomText(
                        text: ' Voucher',
                        fontFamily: 'Montserrat',
                        textColor: Colors.black45,
                      ),
                      const Spacer(),
                      CustomText(text: voucherAmount),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
