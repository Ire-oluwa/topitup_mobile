import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../dashboard/dashboard_screen.dart';
import '../../constants/app_constants.dart';
import 'custom_text.dart';

class CustomScreenBackground extends StatelessWidget {
  const CustomScreenBackground({
    Key? key,
    required this.child,
    required this.screenName,
  }) : super(key: key);

  final Widget child;
  final String screenName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              height: size.height * 0.18,
              color: kPrimaryColour,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushReplacementNamed(
                        DashboardScreen.id,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding.h,
                  ),
                  Center(
                    child: CustomText(
                      text: screenName,
                      textSize: 18.0.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      textColor: Colors.white,
                      alignText: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
