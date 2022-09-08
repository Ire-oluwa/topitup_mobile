import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/available_service.dart';
import '../components/custom_dropdown_form_field.dart';
import 'components/choose_airtime_amount_widget.dart';
import '../../utils/snackbar.dart';
import '../../constants/app_constants.dart';
import '../../models/sub_service.dart';
import '../../providers/api_key_provider.dart';
import '../../providers/device_info_provider.dart';
import '../components/custom_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';
import 'components/network_provider_card_icon.dart';
import 'components/service_type_card.dart';
import 'components/sub_service_type_card.dart';
import '../../services/networking/web_api/data_api.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  static const String id = 'data screen';

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String _paymentPrice = '0.00';
  String _productCode = '';
  bool _isAirtimeActive = false;
  bool _isDataActive = false;
  bool _isDataTopup = false;
  bool _isDataShare = false;
  String _selectedService = '';
  bool _isLoading = false;
  bool _networkProviderIsSelected = false;
  List<SubServiceModel> _subServices = [];
  List<AvailableServiceModel> _availableServices = [];
  final FlutterContactPicker _contactPicker = FlutterContactPicker();

  final _airtimeAndDataFormKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();

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
                                _isAirtimeActive
                                    ? _getSubServices(
                                        apiKey:
                                            context.read<ApiKey>().getApiKey,
                                        deviceId: context
                                            .read<DeviceInfo>()
                                            .getDeviceId,
                                      )
                                    : null;
                              }),
                            ),
                            ServiceTypeCard(
                              label: 'Data',
                              labelColour:
                                  _isDataActive ? Colors.white : kPrimaryColour,
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
                                  _isDataTopup
                                      ? _getSubServices(
                                          apiKey:
                                              context.read<ApiKey>().getApiKey,
                                          deviceId: context
                                              .read<DeviceInfo>()
                                              .getDeviceId,
                                        )
                                      : null;
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
                                      ? _getSubServices(
                                          apiKey:
                                              context.read<ApiKey>().getApiKey,
                                          deviceId: context
                                              .read<DeviceInfo>()
                                              .getDeviceId,
                                        )
                                      : null;
                                }),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: _isAirtimeActive
                              ? kDefaultPadding.h
                              : _isDataActive
                                  ? kDefaultPadding.h * 2
                                  : 0.0,
                        ),
                        if (_isAirtimeActive ||
                            _isDataActive &&
                                _selectedService != "" &&
                                _subServices.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomText(
                                text: 'Select Network Provider',
                                alignText: TextAlign.center,
                                textSize: 16.39.sp,
                                textColor: kPrimaryColour,
                                fontFamily: 'Montserrat',
                              ),
                              SizedBox(
                                height: kDefaultPadding.h - 5,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  spacing: 5,
                                  runSpacing: kDefaultPadding.h,
                                  children: _subServices
                                      .map(
                                        (subService) => NetworkProviderCardIcon(
                                          isSelected:
                                              _networkProviderIsSelected,
                                          serviceName: subService.name!,
                                          networkProviderLogo: subService.code!
                                                  .contains('airtel')
                                              ? 'assets/logos/airtel.png'
                                              : subService.code!.contains('glo')
                                                  ? 'assets/logos/Glo.png'
                                                  : subService.code!
                                                          .contains('9mobile')
                                                      ? 'assets/logos/9mobile.png'
                                                      : 'assets/logos/mtn.png',
                                          onPressed: () async {
                                            // if (subService.name!
                                            //     .contains('mtn')) {
                                            //   setState(() {
                                            //     _networkProviderIsSelected =
                                            //         true;
                                            //   });
                                            // }
                                            setState(() {
                                              _networkProviderIsSelected = true;
                                              _availableServices.clear();
                                            });
                                            await _getAvailableServices(
                                              apiKey: context
                                                  .read<ApiKey>()
                                                  .getApiKey,
                                              deviceId: context
                                                  .read<DeviceInfo>()
                                                  .getDeviceId,
                                              subServiceCode: subService.code!,
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: kDefaultPadding.h * 2,
                        ),
                        const CustomText(
                          text: 'Enter Mobile Number',
                          fontFamily: 'Montserrat',
                          textColor: kPrimaryColour,
                          alignText: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5.h,
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
                              onTap: () async {
                                Contact? selectedContact =
                                    await _contactPicker.selectContact();
                                if (selectedContact == null) {
                                  if (!mounted) return;
                                  displaySnackbar(
                                      context, 'No contact selected.');
                                  return;
                                }
                                final gottenContact =
                                    selectedContact.toString();
                                setState(() {
                                  _mobileNumberController.text = gottenContact
                                      .replaceAll(RegExp(r'[^0-9]'), '');
                                });
                              },
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
                          height: kDefaultPadding.h,
                        ),
                        // if (_isAirtimeActive == false && _isDataActive)
                        CustomDropdownFormField(
                          items: _networkProviderIsSelected
                              ? [
                                  const DropdownMenuItem<String>(
                                    value: 'none',
                                    child: CustomText(
                                      text: 'Select data-topup or data-share',
                                      textColor: kPrimaryColour,
                                      fontWeight: FontWeight.bold,
                                      alignText: TextAlign.center,
                                    ),
                                  ),
                                ]
                              : _availableServices
                                  .map(
                                    (availableService) =>
                                        DropdownMenuItem<String>(
                                      value: availableService.systemName,
                                      child: CustomText(
                                        text:
                                            '${availableService.name!} (₦${availableService.defaultPrice})',
                                        textColor: kPrimaryColour,
                                        fontWeight: FontWeight.bold,
                                        alignText: TextAlign.center,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          selectedItem: (selectedItem) {
                            final selectedPlan = _availableServices.firstWhere(
                                (servize) =>
                                    servize.systemName == selectedItem);
                            setState(() {
                              _productCode = selectedItem!;
                              _paymentPrice = selectedPlan.defaultPrice!;
                            });
                          },
                          hintText: _networkProviderIsSelected
                              ? 'Loading...'
                              : 'Choose Plan',
                          // validate: kRequiredField,
                        ),
                        if (_isDataActive == false)
                          SizedBox(
                            height: kDefaultPadding.h * 2,
                          ),
                        if (_isDataActive == false)
                          ChooseAirtimeAmountWidget(
                            amount: _paymentPrice,
                            onAdd: () => setState(() {
                              _paymentPrice =
                                  (double.parse(_paymentPrice) + 50).toString();
                            }),
                            onSubtract: () {
                              final reducePrice =
                                  double.parse(_paymentPrice) - 50;
                              setState(() {
                                reducePrice > 0
                                    ? _paymentPrice = reducePrice.toString()
                                    : _paymentPrice = '0.00';
                              });
                            },
                          ),
                        SizedBox(
                          height: kDefaultPadding.h * 2,
                        ),
                        CustomTextButton(
                          text: 'Pay: ₦$_paymentPrice',
                          onPressed: () => _submitPayment(
                            context,
                            apiKey: context.read<ApiKey>().getApiKey,
                            deviceId: context.read<DeviceInfo>().getDeviceId,
                          ),
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
      ),
    );
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  Future<void> _getSubServices(
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
      List<SubServiceModel> loadedSubservices = data['data_result']
          .map<SubServiceModel>(SubServiceModel.fromJson)
          .toList();
      // print(loadedSubservices);
      setState(() {
        _subServices = loadedSubservices;
      });
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(
      context,
      'Error occured! Try again later.',
    );
  }

  Future<void> _getAvailableServices(
      {required String subServiceCode,
      required String apiKey,
      required String deviceId}) async {
    _makeLoadingTrue();
    final res = await DataApi.getAvailableServices(
      subServiceCode: subServiceCode,
      apiKey: apiKey,
      deviceId: deviceId,
    );
    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      List<AvailableServiceModel> loadedAvailableServices = data['data_result']
          .map<AvailableServiceModel>(AvailableServiceModel.fromJson)
          .toList();
      // print(loadedAvailableServices.length);
      // print(loadedAvailableServices);
      setState(() {
        _availableServices = loadedAvailableServices;
        _networkProviderIsSelected = false;
      });
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(
      context,
      'Error occured! Try again later.',
    );
  }

  void _submitPayment(BuildContext context,
      {required String apiKey, required String deviceId}) async {
    if (_selectedService != "") {
      if (_airtimeAndDataFormKey.currentState!.validate()) {
        if (_productCode != '') {
          if (_paymentPrice == '0.00' ||
              _paymentPrice == '0.0' ||
              _paymentPrice == '0') {
            displaySnackbar(context, 'Choose an amount!');
            return;
          }
          await _buyAirtime(apiKey: apiKey, deviceId: deviceId);
        }
        if (!mounted) return;
        displaySnackbar(context, 'Select a plan');
        return;
      }
      displaySnackbar(context, 'Enter your mobile number!');
      return;
    }
    displaySnackbar(context, 'Select a service');
  }

  Future<void> _buyAirtime(
      {required String apiKey, required String deviceId}) async {
    _makeLoadingTrue();
    final res = await DataApi.buyAirtime(
      productCode: _productCode,
      apiKey: apiKey,
      deviceId: deviceId,
      recipientPhoneNumber: _mobileNumberController.text,
      orderAmount: double.parse(_paymentPrice).toInt(),
    );
    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      print(data);
      if (!mounted) return;
      displaySnackbar(context, 'Transaction Submitted Successfully');
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(context, 'Transaction Failed');
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
