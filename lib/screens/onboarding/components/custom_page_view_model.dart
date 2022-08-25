import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_constants.dart';
import '../../components/custom_text.dart';

class CustomPageViewModel extends StatelessWidget {
  const CustomPageViewModel({
    Key? key,
    required this.imageUrl,
    required this.headerDescription,
    required this.contentDescription,
    required this.headerColour,
    required this.contentColour,
  }) : super(key: key);

  final String imageUrl, headerDescription, contentDescription;
  final Color headerColour, contentColour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF1F3FB),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding.w,
          ),
          margin: EdgeInsets.only(
            bottom: kDefaultPadding.h * 4.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: headerDescription,
                fontFamily: 'Montserrat',
                textColor: headerColour,
                textSize: 35.sp,
                fontWeight: FontWeight.w700,
                alignText: TextAlign.center,
                softwrap: true,
              ),
              SizedBox(
                height: kDefaultPadding.h,
              ),
              CustomText(
                text: contentDescription,
                textColor: contentColour,
                alignText: TextAlign.center,
                softwrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
