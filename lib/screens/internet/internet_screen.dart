import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_constants.dart';
import '../components/custom_dropdown_form_field.dart';
import '../components/custom_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({Key? key}) : super(key: key);

  static const String id = 'internet screen';

  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  final _internetSubscriptionFormKey = GlobalKey<FormState>();
  final _smartCardNumberController = TextEditingController();
  final _amountController = TextEditingController();

  List<DropdownMenuItem<String>> internetProviderItems = [
    const DropdownMenuItem<String>(
      value: 'spectranetLimited',
      child: Text('Spectranet Limited'),
    ),
    const DropdownMenuItem<String>(
      value: 'smileBundle',
      child: Text('Smile Bundle'),
    ),
    const DropdownMenuItem<String>(
      value: 'coollink',
      child: Text('Coollink'),
    ),
  ];

  List<DropdownMenuItem<String>> internetPackageItems = [
    const DropdownMenuItem<String>(
      value: 'mtn',
      child: Text('MTN'),
    ),
    const DropdownMenuItem<String>(
      value: 'glo',
      child: Text('Glo'),
    ),
    const DropdownMenuItem<String>(
      value: 'airtel',
      child: Text('Airtel'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: CustomScreenBackground(
            screenName: 'Internet',
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w / 2,
                vertical: kDefaultPadding.h + 10,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _internetSubscriptionFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomDropdownFormField(
                        fieldTitle: 'Internet Provider',
                        hintText: 'Select Provider',
                        items: internetProviderItems,
                        selectedItem: ((selectedItem) {}),
                      ),
                      SizedBox(
                        height: kDefaultPadding.h,
                      ),
                      CustomDropdownFormField(
                        fieldTitle: 'Package',
                        hintText: 'Select Package',
                        items: internetPackageItems,
                        selectedItem: ((selectedItem) {}),
                      ),
                      SizedBox(
                        height: kDefaultPadding.h,
                      ),
                      CustomText(
                        text: 'Smart Card Number',
                        fontFamily: 'Montserrat',
                        textSize: 12.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextFormField(
                        controller: _smartCardNumberController,
                        keyboardType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        validate: kRequiredField,
                        placeholder: 'Enter Account/User Id',
                      ),
                      SizedBox(
                        height: kDefaultPadding.h,
                      ),
                      CustomText(
                        text: 'Amount',
                        fontFamily: 'Montserrat',
                        textSize: 12.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        validate: kRequiredField,
                        placeholder: '#1,000',
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _smartCardNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
