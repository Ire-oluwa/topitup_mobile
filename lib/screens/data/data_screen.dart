import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/screens/components/custom_screen_background.dart';
import 'package:topitup/screens/components/custom_text.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  static const String id = 'data screen';

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final _airtimeAndDataFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScreenBackground(
          screenName: 'Airtime & Data',
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w,
                vertical: kDefaultPadding.h,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _airtimeAndDataFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(
                        text: 'Select Netork Provider',
                        alignText: TextAlign.center,
                        textSize: 16.39.sp,
                        textColor: kPrimaryColour,
                      ),
                      SizedBox(
                        height: kDefaultPadding.h,
                      ),
                      Row(
                        children: const [],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
