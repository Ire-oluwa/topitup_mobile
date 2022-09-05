import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/screens/components/custom_dropdown_form_field.dart';
import 'package:topitup/screens/components/custom_screen_background.dart';
import 'package:topitup/screens/components/custom_text.dart';
import 'package:topitup/screens/components/custom_text_button.dart';
import 'package:topitup/screens/components/custom_text_form_field.dart';
import 'package:topitup/screens/data/components/network_provider_card_icon.dart';
import 'package:topitup/screens/data/components/service_type_card.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  static const String id = 'data screen';

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final _airtimeAndDataFormKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem<String>(
      value: '500gb',
      child: Text('500gb'),
    ),
    const DropdownMenuItem<String>(
      value: '1000gb',
      child: Text('1000gb'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: CustomScreenBackground(
            screenName: 'Airtime & Data',
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding.w / 2,
                  vertical: kDefaultPadding.h,
                ),
                child: Form(
                  key: _airtimeAndDataFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Select Netork Provider',
                        alignText: TextAlign.center,
                        textSize: 16.39.sp,
                        textColor: kPrimaryColour,
                        fontFamily: 'Montserrat',
                      ),
                      SizedBox(
                        height: kDefaultPadding.h / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NetworkProviderCardIcon(
                            networkProviderLogo: 'assets/logos/mtn.png',
                            onPressed: () {},
                          ),
                          NetworkProviderCardIcon(
                            networkProviderLogo: 'assets/logos/Glo.png',
                            onPressed: () {},
                          ),
                          NetworkProviderCardIcon(
                            networkProviderLogo: 'assets/logos/airtel.png',
                            onPressed: () {},
                          ),
                          NetworkProviderCardIcon(
                            networkProviderLogo: 'assets/logos/9mobile.png',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kDefaultPadding.h + 10,
                      ),
                      const CustomText(
                        text: 'Enter Mobile Number',
                        fontFamily: 'Montserrat',
                        textColor: kPrimaryColour,
                        alignText: TextAlign.center,
                      ),
                      SizedBox(
                        height: kDefaultPadding.h / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 280.w,
                            child: CustomTextFormField(
                              controller: _mobileNumberController,
                              keyboardType: TextInputType.phone,
                              inputAction: TextInputAction.done,
                              validate: kRequiredField,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: (() {}),
                            child: Card(
                              color: kSecondaryColour,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  10.w,
                                ),
                                child: SvgPicture.asset(
                                  'assets/svg/contact-icon.svg',
                                  height: kDefaultPadding.h + 5,
                                  width: kDefaultPadding.h + 5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: kDefaultPadding.h + 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ServiceTypeCard(
                            label: 'Airtime',
                            labelColour: kPrimaryColour,
                            backgroundColour: const Color(0XFFF8F8F8),
                            onPressed: () {},
                          ),
                          ServiceTypeCard(
                            label: 'Data',
                            labelColour: Colors.white,
                            backgroundColour: kSecondaryColour,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kDefaultPadding.h * 3,
                      ),
                      CustomDropdownFormField(
                        items: items,
                        selectedItem: (selectedItem) {},
                        hintText: 'Choose Plan',
                      ),
                      SizedBox(
                        height: kDefaultPadding.h * 2,
                      ),
                      CustomTextButton(
                        text: 'Pay: 0.00',
                        onPressed: () {},
                        backgroundColour: kPrimaryColour,
                        borderColour: Colors.transparent,
                        textColour: Colors.white,
                        textLabelSize: 18.0.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
