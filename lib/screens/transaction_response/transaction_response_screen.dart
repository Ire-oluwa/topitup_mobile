import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../constants/app_constants.dart';
import '../../extensions/string_extension.dart';
import '../components/custom_text.dart';
import '../dashboard/dashboard_screen.dart';

class TransactionResponseScreen extends StatelessWidget {
  const TransactionResponseScreen({super.key});
  static const String id = 'transaction response screen';

  @override
  Widget build(BuildContext context) {
    final transactionDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedCurrentDate =
        formatter.format(now).split('-').reversed.join('-');
    return Scaffold(
      backgroundColor: kPrimaryColour,
      appBar: AppBar(
        title: CustomText(
          text: 'Transaction Details',
          fontFamily: 'Montserrat',
          textSize: 22.sp,
        ),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: kDefaultPadding.h,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(
              horizontal: kDefaultPadding.w,
              vertical: kDefaultPadding.h / 2,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w / 2,
                vertical: kDefaultPadding.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: kDefaultPadding.w + 10,
                          height: kDefaultPadding.h + 10,
                          padding: EdgeInsets.all(5.w),
                          color: kPrimaryColour,
                          child: SvgPicture.asset(
                            transactionDetails['type'] == 'airtime'
                                ? 'assets/svg/airtime-icon.svg'
                                : 'assets/svg/data-icon.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        text:
                            transactionDetails['type'].toString().capitalize(),
                        textSize: 16.sp,
                        textColor: const Color(0xff605A5A),
                      ),
                      const Spacer(),
                      CustomText(
                        text:
                            '₦${transactionDetails['trx_details'].amountCharged}',
                        textSize: 16.0.sp,
                        textColor: kSecondaryColour,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding.h * 3,
                  ),
                  CustomText(
                    text: transactionDetails['trx_details'].textStatus,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    alignText: TextAlign.center,
                    textSize: 24.sp,
                    textColor: transactionDetails['trx_details'].textStatus ==
                            'COMPLETED'
                        ? const Color(0XFF03943D)
                        : transactionDetails['trx_details'].textStatus ==
                                'PENDING'
                            ? Colors.yellow
                            : Colors.red,
                  ),
                  SizedBox(
                    height: kDefaultPadding.h + 10,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Transaction type:',
                          textSize: 15.sp,
                        ),
                        CustomText(
                          text: transactionDetails['type']
                              .toString()
                              .capitalize(),
                          textSize: 15.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding.h / 2,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Date:',
                          textSize: 15.sp,
                        ),
                        CustomText(
                          text: formattedCurrentDate,
                          textSize: 15.sp,
                        ),
                      ],
                    ),
                  ),
                  if (transactionDetails['trx_details'].serverMessage != null)
                    SizedBox(
                      height: kDefaultPadding.h,
                    ),
                  if (transactionDetails['trx_details'].serverMessage != null)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
                      child: CustomText(
                        text:
                            '${transactionDetails['trx_details'].serverMessage}.',
                        alignText: TextAlign.justify,
                        softwrap: true,
                      ),
                    ),
                  SizedBox(
                    height: kDefaultPadding.h,
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(
              horizontal: kDefaultPadding.w,
              vertical: kDefaultPadding.h / 2,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w,
                vertical: kDefaultPadding.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Transaction ID',
                    textColor: kSecondaryColour,
                    textSize: 16.sp,
                  ),
                  CustomText(
                    text: '${transactionDetails['trx_details'].rechargeId}',
                    textSize: 16.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: kDefaultPadding.h,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(DashboardScreen.id, (route) => false),
            child: const CustomText(
              text: 'Go back home',
              textColor: kSecondaryColour,
              alignText: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
