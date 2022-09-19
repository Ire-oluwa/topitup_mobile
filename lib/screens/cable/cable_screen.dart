import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/models/available_service.dart';
import 'package:topitup/models/sub_service.dart';
import 'package:topitup/models/transaction_response.dart';
import 'package:topitup/providers/api_key_provider.dart';
import 'package:topitup/providers/device_info_provider.dart';
import 'package:topitup/providers/tv_provider.dart';
import 'package:topitup/screens/components/custom_dropdown_form_field.dart';
import 'package:topitup/screens/components/custom_screen_background.dart';
import 'package:topitup/screens/components/custom_text.dart';
import 'package:topitup/screens/components/custom_text_button.dart';
import 'package:topitup/screens/components/custom_text_form_field.dart';
import 'package:topitup/screens/transaction_response/transaction_response_screen.dart';
import 'package:topitup/services/networking/web_api/cable_api.dart';
import 'package:topitup/utils/snackbar.dart';

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
  final _smartCardNumberController = TextEditingController();
  final _cableTvFormKey = GlobalKey<FormState>();
  final List<AvailableServiceModel> _availableServices = [];

  @override
  Widget build(BuildContext context) {
    final tvCables = context.watch<TvCable>().tvCables;
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
                        CustomDropdownFormField(
                          items: tvCables
                              .map(
                                (tvCable) => DropdownMenuItem(
                                  value: tvCable.code,
                                  child: CustomText(
                                    text: '${tvCable.name}',
                                    textSize: 16.sp,
                                    textColor: kPrimaryColour,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              )
                              .toList(),
                          selectedItem: (selectedItem) async {
                            await _getAvailableServices(
                              subServiceCode: selectedItem!,
                              apiKey: context.read<ApiKey>().getApiKey,
                              deviceId: context.read<DeviceInfo>().getDeviceId,
                            );
                          },
                          hintText: tvCables.isEmpty
                              ? 'Loading...'
                              : 'Select provider',
                          validate: kRequiredField,
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
                                        '${availableService.name!} (₦${availableService.defaultPrice})',
                                    textColor: kPrimaryColour,
                                    fontWeight: FontWeight.bold,
                                    alignText: TextAlign.center,
                                    textSize: 14.sp,
                                    overflow: TextOverflow.clip,
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
                          hintText: 'Select package',
                          validate: kRequiredField,
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
  void didChangeDependencies() {
    _getCableSubscriptions(
      context: context,
      apiKey: context.read<ApiKey>().getApiKey,
      deviceId: context.read<DeviceInfo>().getDeviceId,
    );
    super.didChangeDependencies();
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

  void _submitPayment(BuildContext context,
      {required String apiKey, required String deviceId}) async {
    if (_cableTvFormKey.currentState!.validate()) {
      if (_productCode != '') {
        if (_paymentPrice == '0.00' ||
            _paymentPrice == '0.0' ||
            _paymentPrice == '0') {
          displaySnackbar(context, 'Choose an amount!');
          return;
        }
        await _buyTvSubscription(apiKey: apiKey, deviceId: deviceId);
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
