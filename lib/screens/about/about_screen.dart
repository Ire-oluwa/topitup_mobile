import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../constants/app_constants.dart';
import '../components/custom_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  static const String id = 'about screen';

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy');
    final formattedYear = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'About',
          textSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/logo-full.png'),
            SizedBox(
              height: kDefaultPadding.h * 2,
            ),
            const CustomText(
              text: 'Version 1.0',
              alignText: TextAlign.center,
            ),
            const Spacer(),
            CustomText(
              text: 'Topitupng',
              alignText: TextAlign.center,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
            CustomText(
              text: formattedYear,
              alignText: TextAlign.center,
              textSize: 12.sp,
              fontWeight: FontWeight.w500,
              textColor: Colors.black,
            ),
            SizedBox(
              height: kDefaultPadding.h * 2,
            ),
            const CustomText(
              text: 'All rights reserved',
              alignText: TextAlign.center,
            ),
            SizedBox(
              height: kDefaultPadding.h / 2,
            ),
            CustomText(
              text: 'www.topitupng.com',
              alignText: TextAlign.center,
              textSize: 12.sp,
              textColor: const Color(0xff605A5A),
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
          ],
        ),
      ),
    );
  }
}
