import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../constants/app_constants.dart';
import '../home/home_screen.dart';
import 'components/custom_page_view_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static const String id = 'onboarding screen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Widget> onboardingPages = [
    const CustomPageViewModel(
      imageUrl: 'assets/onboarding/onboarding_image_1.png',
      headerDescription: 'Pay your bills on the Go without stress',
      contentDescription:
          'Avoid all forms of long queue.\nDo it at the comfort of your room.',
      headerColour: kPrimaryColour,
      contentColour: Colors.black,
    ),
    const CustomPageViewModel(
      imageUrl: 'assets/onboarding/onboarding_image_2.png',
      headerDescription: 'Top it Up',
      contentDescription:
          'Do not allow airtime make you stranded.\nEasily recharge your line and subscribe as well.',
      headerColour: Colors.white,
      contentColour: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F3FB),
      body: SafeArea(
        child: IntroductionScreen(
          rawPages: onboardingPages,
          onDone: () => Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.id,
            (route) => false,
          ),
          onSkip: () => Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.id,
            (route) => false,
          ),
          done: Text(
            'Get Started',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: kSecondaryColour,
              fontSize: 16.0.sp,
            ),
          ),
          showSkipButton: true,
          skip: Text(
            'Skip',
            style: TextStyle(
              color: kSecondaryColour,
              fontSize: 16.0.sp,
            ),
          ),
          next: FaIcon(
            FontAwesomeIcons.arrowRight,
            size: kDefaultIconSize.sp,
            color: kSecondaryColour,
          ),
          dotsDecorator: const DotsDecorator(
            activeColor: kSecondaryColour,
          ),
        ),
      ),
    );
  }
}
