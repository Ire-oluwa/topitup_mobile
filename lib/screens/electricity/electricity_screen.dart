import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import '../components/custom_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({Key? key}) : super(key: key);

  static const String id = 'electricity screen';

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  final _electricityFormKey = GlobalKey<FormState>();
  final _meterNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final String _paymentPrice = '0.00';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: CustomScreenBackground(
            screenName: 'Electricity',
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding.w / 2,
                vertical: kDefaultPadding.h,
              ),
              child: Form(
                  key: _electricityFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CustomText(
                          text: 'Service Provider',
                          fontFamily: 'Montserrat',
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        DropdownSearch<String>(
                          popupProps: PopupProps.modalBottomSheet(
                            showSelectedItems: true,
                            showSearchBox: true,
                            modalBottomSheetProps: const ModalBottomSheetProps(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                            ),
                            searchFieldProps: TextFieldProps(
                              decoration: kDropdownFieldDecoration.copyWith(
                                prefixIcon: const Icon(Icons.search),
                                hintText: 'Search',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                  borderSide: kLightBorderSide,
                                ),
                              ),
                            ),
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                kDropdownFieldDecoration.copyWith(
                              hintText: 'Select provider',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),
                                borderSide: kLightBorderSide,
                              ),
                            ),
                          ),
                          items: const [
                            "Brazil",
                            "Italia (Disabled)",
                            "Tunisia",
                            'Canada'
                          ],
                          onChanged: (selectedItem) {
                            print(selectedItem);
                          },
                        ),
                        SizedBox(
                          height: kDefaultPadding.h,
                        ),
                        const CustomText(
                          text: 'Meter Number',
                          fontFamily: 'Montserrat',
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomTextFormField(
                          controller: _meterNumberController,
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: kDefaultPadding.h,
                        ),
                        const CustomText(
                          text: 'Select package',
                          fontFamily: 'Montserrat',
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50.h,
                                child: CustomTextButton(
                                  text: 'Postpaid',
                                  onPressed: () {},
                                  backgroundColour: kPrimaryColour,
                                  borderColour: Colors.transparent,
                                  textColour: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: kDefaultPadding.w,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50.h,
                                child: CustomTextButton(
                                  text: 'Prepaid',
                                  onPressed: () {},
                                  backgroundColour: Colors.transparent,
                                  borderColour: kPrimaryColour,
                                  textColour: kPrimaryColour,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding.h,
                        ),
                        const CustomText(
                          text: 'Amount',
                          fontFamily: 'Montserrat',
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomTextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: kDefaultPadding.h * 2,
                        ),
                        CustomTextButton(
                          text: 'Pay: ₦$_paymentPrice',
                          onPressed: () {
                            //    _submitPayment(
                            //   context,
                            //   apiKey: context.read<ApiKey>().getApiKey,
                            //   deviceId: context.read<DeviceInfo>().getDeviceId,
                            // );
                          },
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
      ),
    );
  }
}
