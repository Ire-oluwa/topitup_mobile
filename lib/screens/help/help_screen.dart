import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import '../components/custom_text.dart';
import 'components/custom_support_icon.dart';
import 'components/help_screen_menu.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  static const String id = 'help and support screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Help & Support',
          textSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding.h + 10,
          horizontal: kDefaultPadding.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kDefaultPadding.h * 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0.w),
              child: const CustomText(
                text: 'Help',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
            HelpScreenMenu(
              label: 'Frequently Asked Questions',
              onPressed: () {},
            ),
            HelpScreenMenu(
              label: 'Terms and Conditions',
              onPressed: () {},
            ),
            HelpScreenMenu(
              label: 'Privacy Policy',
              onPressed: () {},
            ),
            SizedBox(
              height: kDefaultPadding.h * 3,
            ),
            Divider(
              thickness: 1,
              height: 2.h,
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0.w),
              child: const CustomText(
                text: 'Support',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SupportIcon(
                  iconPath: 'assets/svg/covered-phone-icon.svg',
                  onPressed: () {},
                ),
                SupportIcon(
                  iconPath: 'assets/svg/covered-mail-icon.svg',
                  onPressed: () {},
                ),
                SupportIcon(
                  iconPath: 'assets/svg/covered-fb-icon.svg',
                  onPressed: () {},
                ),
                SupportIcon(
                  iconPath: 'assets/svg/covered-twitter-icon.svg',
                  onPressed: () {},
                ),
                SupportIcon(
                  iconPath: 'assets/svg/covered-instagram-icon.svg',
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
