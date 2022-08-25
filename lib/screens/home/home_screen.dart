import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import '../components/custom_auth_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = 'home screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomAuthScreenBackground(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding.w - 5,
              vertical: kDefaultPadding.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: kDefaultPadding.h * 2.5,
                ),
                CustomText(
                  text: 'Get started with',
                  textSize: 20.0.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  alignText: TextAlign.center,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text: 'Topitupng',
                  textSize: 40.0.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  alignText: TextAlign.center,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: kDefaultPadding.h * 2,
                ),
                CustomText(
                  text: 'Provide us with your adequate details where necesary',
                  alignText: TextAlign.center,
                  softwrap: true,
                  textSize: 16.0.sp,
                  fontWeight: FontWeight.w300,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: kDefaultPadding.h * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding.w * 4,
                  ),
                  child: CustomTextButton(
                    text: 'Login',
                    onPressed: () => Navigator.of(context).pushNamed(
                      LoginScreen.id,
                    ),
                    backgroundColour: kSecondaryColour,
                    borderColour: Colors.transparent,
                    textColour: Colors.white,
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding.h - 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding.w * 4,
                  ),
                  child: CustomTextButton(
                    text: 'Sign Up',
                    onPressed: () {},
                    backgroundColour: Colors.transparent,
                    borderColour: kSecondaryColour,
                    textColour: kSecondaryColour,
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding.h + 15,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Image.asset(
                        'assets/young_woman.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
