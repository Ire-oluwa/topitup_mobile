import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/sub_service.dart';
import '../../providers/api_key_provider.dart';
import '../../providers/device_info_provider.dart';
import '../components/custom_dropdown_form_field.dart';
import '../components/custom_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';
import 'components/network_provider_card_icon.dart';
import 'components/service_type_card.dart';
import 'components/sub_service_type_card.dart';
import '../../services/networking/web_api/data_api.dart';
import '../../utils/snackbar.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  static const String id = 'data screen';

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool _isAirtimeActive = false;
  bool _isDataActive = false;
  bool _isDataTopup = false;
  bool _isDataShare = false;
  String _selectedService = '';
  bool _isLoading = false;

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
          child: LoadingOverlay(
            isLoading: _isLoading,
            child: CustomScreenBackground(
              screenName: 'Airtime & Data',
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding.w / 2,
                    vertical: kDefaultPadding.h,
                  ),
                  child: Form(
                    key: _airtimeAndDataFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ServiceTypeCard(
                                label: 'Airtime',
                                labelColour: _isAirtimeActive
                                    ? Colors.white
                                    : kPrimaryColour,
                                backgroundColour: _isAirtimeActive
                                    ? kSecondaryColour
                                    : const Color(0XFFF8F8F8),
                                onPressed: () => setState(() {
                                  _isAirtimeActive = !_isAirtimeActive;
                                  _isAirtimeActive
                                      ? _selectedService = 'mobile_topup'
                                      : _selectedService = '';
                                  _isDataActive = false;
                                }),
                              ),
                              ServiceTypeCard(
                                label: 'Data',
                                labelColour: _isDataActive
                                    ? Colors.white
                                    : kPrimaryColour,
                                backgroundColour: _isDataActive
                                    ? kSecondaryColour
                                    : const Color(0XFFF8F8F8),
                                onPressed: () => setState(() {
                                  _isDataActive = !_isDataActive;
                                  _isAirtimeActive = false;
                                }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding.h + 10,
                          ),
                          if (_isDataActive)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SubServiceTypeCard(
                                  label: 'Data Topup',
                                  labelColour: _isDataTopup
                                      ? Colors.white
                                      : kPrimaryColour,
                                  backgroundColour: _isDataTopup
                                      ? kSecondaryColour
                                      : const Color(0XFFF8F8F8),
                                  onPressed: () => setState(() {
                                    _isDataTopup = !_isDataTopup;
                                    _isDataTopup
                                        ? _selectedService = 'data_topup'
                                        : _selectedService = '';
                                    _isDataShare = false;
                                  }),
                                ),
                                SubServiceTypeCard(
                                  label: 'SME Data Share',
                                  labelColour: _isDataShare
                                      ? Colors.white
                                      : kPrimaryColour,
                                  backgroundColour: _isDataShare
                                      ? kSecondaryColour
                                      : const Color(0XFFF8F8F8),
                                  onPressed: () => setState(() {
                                    _isDataShare = !_isDataShare;
                                    _isDataShare
                                        ? _selectedService = 'sme_data_share'
                                        : _selectedService = '';
                                    _isDataTopup = false;
                                    _isDataShare
                                        ? _getSmeDataShareServices(
                                            apiKey: context
                                                .read<ApiKey>()
                                                .getApiKey,
                                            deviceId: context
                                                .read<DeviceInfo>()
                                                .getDeviceId,
                                          )
                                        : null;
                                  }),
                                ),
                              ],
                            ),
                          if (_isDataActive)
                            SizedBox(
                              height: kDefaultPadding.h * 2,
                            ),
                          CustomText(
                            text: 'Select Network Provider',
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
                            height: kDefaultPadding.h * 2,
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
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  _getSmeDataShareServices(
      {required String apiKey, required String deviceId}) async {
    _makeLoadingTrue();
    final res = await DataApi.getSubServices(
      serviceCode: _selectedService,
      apiKey: apiKey,
      deviceId: deviceId,
    );
    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      List<SubServiceModel> subservices = data['data_result']
          .map<SubServiceModel>(SubServiceModel.fromJson)
          .toList();
      print(subservices);
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(
      context,
      'Error occured! Try again later.',
    );
  }

  void _makeLoadingFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  void _makeLoadingTrue() {
    setState(() {
      _isLoading = true;
    });
  }
}
