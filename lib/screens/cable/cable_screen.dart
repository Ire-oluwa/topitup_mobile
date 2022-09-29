import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/customer_cable_verification.dart';
import '../../providers/wallet_balance_provider.dart';
import '../dashboard/dashboard_screen.dart';
import '../../utils/dialogs.dart';

import '../../constants/app_constants.dart';
import '../../models/available_service.dart';
import '../../models/sub_service.dart';
import '../../models/transaction_response.dart';
import '../../providers/api_key_provider.dart';
import '../../providers/device_info_provider.dart';
import '../../providers/tv_provider.dart';
import '../../services/networking/web_api/cable_api.dart';
import '../../utils/snackbar.dart';
import '../components/custom_dropdown_form_field.dart';
import '../components/custom_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';
import '../transaction_response/transaction_response_screen.dart';

class CableScreen extends StatefulWidget {
  const CableScreen({Key? key}) : super(key: key);

  static const String id = 'cable tv screen';

  @override
  State<CableScreen> createState() => _CableScreenState();
}

class _CableScreenState extends State<CableScreen> {
  String _paymentPrice = '0.00';
  String _productCode = '';
  bool _isLoading = false;
  CustomerCableVerification? _verificationData;
  final _smartCardNumberController = TextEditingController();
  final _cableTvFormKey = GlobalKey<FormState>();
  List<AvailableServiceModel> _availableServices = [
    AvailableServiceModel(
      name: 'Choose package',
      systemName: '',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final tvCables = context.read<TvCable>().tvCables;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: LoadingOverlay(
            isLoading: _isLoading,
            child: CustomScreenBackground(
              screenName: 'Cable TV',
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding.w / 2,
                  vertical: kDefaultPadding.h,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _cableTvFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          text: 'TV Provider',
                          fontFamily: 'Montserrat',
                          textColor: kPrimaryColour,
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
                          items:
                              tvCables.map((tvCable) => tvCable.name!).toList(),
                          onChanged: (selectedItem) async {
                            final selectedCable = tvCables.firstWhere(
                                (cable) => cable.name == selectedItem);
                            await _getAvailableServices(
                              subServiceCode: selectedCable.code!,
                              apiKey: context.read<ApiKey>().getApiKey,
                              deviceId: context.read<DeviceInfo>().getDeviceId,
                            );
                          },
                        ),
                        SizedBox(
                          height: kDefaultPadding.h,
                        ),
                        const CustomText(
                          text: 'Smart Card Number',
                          fontFamily: 'Montserrat',
                          textColor: kPrimaryColour,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomTextFormField(
                          controller: _smartCardNumberController,
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.done,
                          validate: kRequiredField,
                          onKeyUp: (p0) async {
                            if (_productCode != '') {
                              await _verifyCustomer(
                                  apiKey: context.read<ApiKey>().getApiKey);
                              return;
                            }
                          },
                        ),
                        SizedBox(
                          height: kDefaultPadding.h,
                        ),
                        const CustomText(
                          text: 'Package',
                          fontFamily: 'Montserrat',
                          textColor: kPrimaryColour,
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
                                    text:
                                        '${availableService.name!} ${availableService.defaultPrice != null ? '(₦${availableService.defaultPrice})' : ''}',
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
                            final selectedPlan = _availableServices.firstWhere(
                                (servize) =>
                                    servize.systemName == selectedItem);
                            setState(() {
                              _productCode = selectedItem!;
                              _paymentPrice = selectedPlan.defaultPrice!;
                            });
                            if (_productCode != '') {
                              await _verifyCustomer(
                                apiKey: context.read<ApiKey>().getApiKey,
                              );
                            }
                          },
                          hintText: 'Select package',
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                        child: CustomText(
                                          text:
                                              _verificationData!.customerName!,
                                          textSize: 16.sp,
                                        ),
                                      ),
                                      FittedBox(
                                        child: CustomText(
                                          text: _verificationData!
                                              .smartCardNumber!,
                                          textSize: 16.sp,
                                        ),
                                      ),
                                    ],
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
    _getCableSubscriptions(
      context: context,
      apiKey: context.read<ApiKey>().getApiKey,
      deviceId: context.read<DeviceInfo>().getDeviceId,
    );
    super.initState();
  }

  @override
  void dispose() {
    _smartCardNumberController.dispose();
    super.dispose();
  }

  Future<void> _getCableSubscriptions(
      {required BuildContext context,
      required String apiKey,
      required String deviceId}) async {
    final res =
        await CableApi.getSubServices(apiKey: apiKey, deviceId: deviceId);

    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      List<SubServiceModel> loadedSubservices = data['data_result']
          .map<SubServiceModel>(SubServiceModel.fromJson)
          .toList();
      // print(loadedSubservices);
      setState(() {
        _availableServices.clear();
        _availableServices = [
          AvailableServiceModel(name: 'Choose package', systemName: '')
        ];
        context.read<TvCable>().setTvCables = loadedSubservices;
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
    final res = await CableApi.getAvailableServices(
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
    final res = await CableApi.verifyCustomer(
      smartCardNumber: _smartCardNumberController.text,
      productCode: _productCode,
      apiKey: apiKey,
    );
    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      final loadedVerificationData =
          CustomerCableVerification.fromJson(data['data']);
      setState(() {
        _verificationData = loadedVerificationData;
      });
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(
      context,
      'Error verifying card details! Try again later.',
    );
  }

  Future<void> _submitPayment(BuildContext context,
      {required String apiKey, required String deviceId}) async {
    if (_cableTvFormKey.currentState!.validate()) {
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
          await _buyTvSubscription(apiKey: apiKey, deviceId: deviceId);
          return;
        }
        if (!mounted) return;
        displaySnackbar(context, 'Invalid smartcard number!');
        return;
      }
      if (!mounted) return;
      displaySnackbar(context, 'Select a package!');
      return;
    }
    displaySnackbar(context, 'Fill the form properly!');
  }

  Future<void> _buyTvSubscription(
      {required String apiKey, required String deviceId}) async {
    _makeLoadingTrue();
    final res = await CableApi.buyTvSubscription(
      productCode: _productCode,
      apiKey: apiKey,
      deviceId: deviceId,
      recipientCardNumber: _smartCardNumberController.text,
      orderAmount: double.parse(_paymentPrice).toInt(),
    );
    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      final transactionResponse =
          TransactionResponseModel.fromJson(data['data']);
      if (!mounted) return;
      Navigator.of(context)
          .pushNamed(TransactionResponseScreen.id, arguments: <String, dynamic>{
        'type': 'Tv Subscription',
        'server_msg': data['server_message'],
        'trx_details': transactionResponse
      });
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(context, 'Error Occured! Try again later.');
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
