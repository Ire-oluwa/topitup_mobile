import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_constants.dart';
import '../components/custom_text.dart';
import 'components/custom_settings_screen_menu.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const String id = 'settings screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: 'Settings',
          textSize: 20.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding.h + 10,
          horizontal: kDefaultPadding.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsMenu(
              iconPath: 'assets/svg/covered-lock-icon.svg',
              menuLabel: 'Change Password',
              onPressed: () {},
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
            SettingsMenu(
              iconPath: 'assets/svg/covered-forgot-pin-icon.svg',
              menuLabel: 'Forgot Pin',
              onPressed: () {},
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
            SettingsMenu(
              iconPath: 'assets/svg/covered-forgot-pin-icon.svg',
              menuLabel: 'Change Pin',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
