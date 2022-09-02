import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/screens/components/custom_text.dart';

class CustomScreenBackground extends StatelessWidget {
  const CustomScreenBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

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
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              height: size.height * 0.15,
              color: kPrimaryColour,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                        size: kDefaultIconSize.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding.h + 10,
                  ),
                  Center(
                    child: CustomText(
                      text: 'Internet',
                      textSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      textColor: Colors.white,
                      alignText: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: kDefaultPadding.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding.w,
            ),
            child: child,
          )
        ],
      ),
    );
  }
}
