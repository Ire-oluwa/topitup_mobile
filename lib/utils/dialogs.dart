import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_constants.dart';
import '../screens/components/custom_text.dart';
import '../screens/components/custom_text_button.dart';

void displayInsufficientWallentBalanceDialog(BuildContext context,
    {required Function() refresh, required Function() topUp}) {
  Platform.isIOS
      ? showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                height: 300.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0.w,
                    vertical: kDefaultPadding.h / 2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/warning-icon.svg',
                        height: 75.h,
                        width: 75.w,
                      ),
                      SizedBox(
                        height: kDefaultPadding.h,
                      ),
                      CustomText(
                        text:
                            'Insufficient Credit\nPlease fund your account, or go home to refresh wallet',
                        textSize: 16.sp,
                        alignText: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: kDefaultPadding.h + 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150.w,
                            height: 50.h,
                            child: CustomTextButton(
                              text: 'Cancel',
                              onPressed: refresh,
                              backgroundColour: Colors.transparent,
                              borderColour: kPrimaryColour,
                              textColour: kPrimaryColour,
                            ),
                          ),
                          SizedBox(
                            width: 150.w,
                            height: 50.h,
                            child: CustomTextButton(
                              text: 'Top up',
                              onPressed: topUp,
                              backgroundColour: kPrimaryColour,
                              borderColour: Colors.transparent,
                              textColour: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      : showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                height: 280.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0.w,
                    vertical: kDefaultPadding.h / 2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/warning-icon.svg',
                        height: 75.h,
                        width: 75.w,
                      ),
                      SizedBox(
                        height: kDefaultPadding.h,
                      ),
                      CustomText(
                        text:
                            'Insufficient Credit, Please fund your account and try again',
                        textSize: 18.sp,
                        alignText: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: kDefaultPadding.h + 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150.w,
                            height: 50.h,
                            child: CustomTextButton(
                              text: 'Refresh',
                              onPressed: refresh,
                              backgroundColour: Colors.transparent,
                              borderColour: kPrimaryColour,
                              textColour: kPrimaryColour,
                            ),
                          ),
                          SizedBox(
                            width: 150.w,
                            height: 50.h,
                            child: CustomTextButton(
                              text: 'Top up',
                              onPressed: topUp,
                              backgroundColour: kPrimaryColour,
                              borderColour: Colors.transparent,
                              textColour: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}
