import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/available_service.dart';
import '../../models/customer_verification.dart';
import '../../models/transaction_response.dart';
import '../../providers/wallet_balance_provider.dart';
import '../components/custom_dropdown_form_field.dart';
import '../dashboard/dashboard_screen.dart';
import '../transaction_response/transaction_response_screen.dart';
import '../../utils/dialogs.dart';
import '../../models/main_service.dart';
import '../../providers/api_key_provider.dart';
import '../../providers/device_info_provider.dart';
import '../../providers/electricity_provider.dart';
import '../../services/networking/web_api/electricity_api.dart';
import '../../utils/snackbar.dart';

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
  bool _isLoading = false;
  final _electricityFormKey = GlobalKey<FormState>();
  final _meterNumberController = TextEditingController();
  final _amountController = TextEditingController();
  String _paymentPrice = '0.00';
  String _productCode = '';
  String _postPaid = '';
  String _prePaid = '';
  bool _isPostPaidActive = false;
  bool _isPrepaidActive = false;
  CustomerMeterVerification? _verificationData;
  List<AvailableServiceModel> _availableServices = [
    AvailableServiceModel(
      name: 'Choose product',
      systemName: '',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final electricityDistributions =
        context.read<Electricity>().electricityDistributions;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: LoadingOverlay(
            isLoading: _isLoading,
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
                          items: electricityDistributions
                              .map((electricityDistribution) =>
                                  electricityDistribution.serviceName!)
                              .toList(),
                          onChanged: (selectedItem) {
                            final selectedDistribution =
                                electricityDistributions.firstWhere(
                                    (electricityDistribution) =>
                                        electricityDistribution.serviceName ==
                                        selectedItem);
                            setState(() {
                              _postPaid =
                                  '${selectedDistribution.serviceCode}_postpaid';
                              _prePaid =
                                  '${selectedDistribution.serviceCode}_prepaid';
                              _isPostPaidActive = false;
                              _isPrepaidActive = false;
                            });
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
                          onKeyUp: (p0) async {
                            if (_productCode != '') {
                              await _verifyCustomer(
                                  apiKey: context.read<ApiKey>().getApiKey);
                              return;
                            }
                          },
                          controller: _meterNumberController,
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          validate: kRequiredField,
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
                                  onPressed: () async {
                                    setState(() {
                                      _isPostPaidActive = true;
                                      _isPrepaidActive = false;
                                      _availableServices.clear();
                                      _availableServices = [
                                        AvailableServiceModel(
                                            name: 'Choose product',
                                            systemName: '')
                                      ];
                                    });
                                    await _getAvailableServices(
                                      apiKey: context.read<ApiKey>().getApiKey,
                                      deviceId: context
                                          .read<DeviceInfo>()
                                          .getDeviceId,
                                      subServiceCode: _postPaid,
                                    );
                                  },
                                  backgroundColour: _isPostPaidActive
                                      ? kPrimaryColour
                                      : Colors.transparent,
                                  borderColour: _isPostPaidActive
                                      ? Colors.transparent
                                      : kPrimaryColour,
                                  textColour: _isPostPaidActive
                                      ? Colors.white
                                      : kPrimaryColour,
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
                                  onPressed: () async {
                                    setState(() {
                                      _isPrepaidActive = true;
                                      _isPostPaidActive = false;
                                      _availableServices.clear();
                                      _availableServices = [
                                        AvailableServiceModel(
                                            name: 'Choose product',
                                            systemName: '')
                                      ];
                                    });
                                    await _getAvailableServices(
                                      apiKey: context.read<ApiKey>().getApiKey,
                                      deviceId: context
                                          .read<DeviceInfo>()
                                          .getDeviceId,
                                      subServiceCode: _prePaid,
                                    );
                                  },
                                  backgroundColour: _isPrepaidActive
                                      ? kPrimaryColour
                                      : Colors.transparent,
                                  borderColour: _isPrepaidActive
                                      ? Colors.transparent
                                      : kPrimaryColour,
                                  textColour: _isPrepaidActive
                                      ? Colors.white
                                      : kPrimaryColour,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding.h,
                        ),
                        const CustomText(
                          text: 'Product',
                          fontFamily: 'Montserrat',
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomDropdownFormField(
                          items: _availableServices
                              .map(
                                (availableService) => DropdownMenuItem<String>(
                                  value: availableService.systemName,
                                  child: CustomText(
                                    text: availableService.name!,
                                    textColor: kPrimaryColour,
                                    fontWeight: FontWeight.bold,
                                    alignText: TextAlign.center,
                                    textSize: 14.sp,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                              .toList(),
                          selectedItem: (selectedItem) async {
                            setState(() {
                              _productCode = selectedItem!;
                            });
                            if (_productCode != '' &&
                                _meterNumberController.text != '') {
                              await _verifyCustomer(
                                apiKey: context.read<ApiKey>().getApiKey,
                              );
                            }
                          },
                          hintText: 'Select product',
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
                          onKeyUp: (p0) {
                            setState(() {
                              _paymentPrice = p0;
                            });
                          },
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.done,
                          validate: kRequiredField,
                        ),
                        if (_verificationData != null)
                          SizedBox(
                            height: kDefaultPadding.h + 10,
                          ),
                        if (_verificationData != null)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomText(
                                  text: _verificationData!.textStatus!,
                                  textSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: _verificationData!.textStatus!
                                              .contains('SUCCESSFUL') ||
                                          _verificationData!.textStatus!
                                              .contains('successful')
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                SizedBox(
                                  height: kDefaultPadding.h,
                                ),
                                if (_verificationData!.textStatus!
                                        .contains('SUCCESSFUL') ||
                                    _verificationData!.textStatus!
                                        .contains('successful'))
                                  CustomText(
                                    text:
                                        'Name: ${_verificationData!.customerName!}',
                                    textSize: 16.sp,
                                  ),
                                if (_verificationData!.textStatus!
                                        .contains('SUCCESSFUL') ||
                                    _verificationData!.textStatus!
                                        .contains('successful'))
                                  SizedBox(
                                    height: kDefaultPadding.h / 2,
                                  ),
                                if (_verificationData!.textStatus!
                                        .contains('SUCCESSFUL') ||
                                    _verificationData!.textStatus!
                                        .contains('successful'))
                                  CustomText(
                                    text:
                                        'Meter: ${_verificationData!.meterNumber!}',
                                    textSize: 16.sp,
                                  ),
                                if (_verificationData!.textStatus!
                                        .contains('SUCCESSFUL') ||
                                    _verificationData!.textStatus!
                                        .contains('successful'))
                                  SizedBox(
                                    height: kDefaultPadding.h / 2,
                                  ),
                                if (_verificationData!.textStatus!
                                        .contains('SUCCESSFUL') ||
                                    _verificationData!.textStatus!
                                        .contains('successful'))
                                  CustomText(
                                    text:
                                        'Phone: ${_verificationData!.customerNumber!}',
                                    textSize: 16.sp,
                                  ),
                                if (_verificationData!.textStatus!
                                        .contains('SUCCESSFUL') ||
                                    _verificationData!.textStatus!
                                        .contains('successful'))
                                  SizedBox(
                                    height: kDefaultPadding.h / 2,
                                  ),
                                if (_verificationData!.textStatus!
                                        .contains('SUCCESSFUL') ||
                                    _verificationData!.textStatus!
                                        .contains('successful'))
                                  CustomText(
                                    text:
                                        'Address: ${_verificationData!.customerAddress!}',
                                    textSize: 16.sp,
                                    softwrap: true,
                                  ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: kDefaultPadding.h * 2,
                        ),
                        CustomTextButton(
                          text: 'Pay: ₦$_paymentPrice',
                          onPressed: () async => await _submitPayment(
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
  void initState() {
    _getMainDistributionServices(
      context: context,
      apiKey: context.read<ApiKey>().getApiKey,
      deviceId: context.read<DeviceInfo>().getDeviceId,
    );
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _meterNumberController.dispose();
    super.dispose();
  }

  Future<void> _submitPayment(BuildContext context,
      {required String apiKey, required String deviceId}) async {
    if (_electricityFormKey.currentState!.validate()) {
      if (_postPaid != '' && _prePaid != '' && _isPostPaidActive ||
          _isPrepaidActive) {
        if (_productCode != '') {
          if (_paymentPrice == '0.00' ||
              _paymentPrice == '0.0' ||
              _paymentPrice == '0') {
            displaySnackbar(context, 'Choose an amount!');
            return;
          }
          if (_verificationData != null &&
                  _verificationData!.textStatus!.contains('SUCCESSFUL') ||
              _verificationData!.textStatus!.contains('successful')) {
            final walletBalance = context.read<WalletBalance>().walletBalance;
            if (double.parse(_paymentPrice) > walletBalance) {
              displayInsufficientWallentBalanceDialog(
                context,
                refresh: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    DashboardScreen.id, (route) => false),
                topUp: () {},
              );
              return;
            }
            await _buyElectricToken(apiKey: apiKey, deviceId: deviceId);
            return;
          }
          if (!mounted) return;
          displaySnackbar(context, 'Invalid meter number!');
          return;
        }
        if (!mounted) return;
        displaySnackbar(context, 'Select a product!');
        return;
      }
      if (!mounted) return;
      displaySnackbar(context, 'Select a package!');
      return;
    }
    displaySnackbar(context, 'Fill the form properly!');
  }

  Future<void> _buyElectricToken(
      {required String apiKey, required String deviceId}) async {
    _makeLoadingTrue();
    final res = await ElectricityApi.buyElectricToken(
        productCode: _productCode,
        recipientCardNumber: _meterNumberController.text,
        orderAmount: int.parse(_paymentPrice),
        apiKey: apiKey,
        deviceId: deviceId);
    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      final transactionResponse =
          TransactionResponseModel.fromJson(data['data']);
      if (!mounted) return;
      Navigator.of(context)
          .pushNamed(TransactionResponseScreen.id, arguments: <String, dynamic>{
        'type': 'Electric Token',
        'server_msg': data['server_message'],
        'trx_details': transactionResponse
      });
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(context, 'Error Occured! Try again later.');
  }

  void _getMainDistributionServices(
      {required BuildContext context,
      required String apiKey,
      required String deviceId}) async {
    final res = await ElectricityApi.getMainServices(
        apiKey: apiKey, deviceId: deviceId);

    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      List<MainServiceModel> loadedMainservices = data['data_result']
          .map<MainServiceModel>(MainServiceModel.fromJson)
          .toList();
      final loadedDistributionServices = loadedMainservices
          .where((distributionService) =>
              distributionService.serviceCode!.contains('distribution'))
          .toList();
      setState(() {
        _availableServices.clear();
        _availableServices = [
          AvailableServiceModel(name: 'Choose product', systemName: '')
        ];
        context.read<Electricity>().setElectricityDistributions =
            loadedDistributionServices;
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
    final res = await ElectricityApi.getAvailableServices(
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
      setState(() {
        _availableServices.clear();
        _availableServices.addAll(loadedAvailableServices);
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

  Future<void> _verifyCustomer({required String apiKey}) async {
    _makeLoadingTrue();
    final res = await ElectricityApi.verifyCustomer(
      meterNumber: _meterNumberController.text,
      productCode: _productCode,
      apiKey: apiKey,
    );
    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      final loadedVerificationData =
          CustomerMeterVerification.fromJson(data['data']);
      setState(() {
        _verificationData = loadedVerificationData;
      });
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(
      context,
      'Error verifying meter details! Try again later.',
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
