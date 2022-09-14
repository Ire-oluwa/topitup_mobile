import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/models/sub_service.dart';
import 'package:topitup/providers/api_key_provider.dart';
import 'package:topitup/providers/device_info_provider.dart';
import 'package:topitup/screens/components/custom_dropdown_form_field.dart';
import 'package:topitup/screens/components/custom_screen_background.dart';
import 'package:topitup/screens/components/custom_text.dart';
import 'package:topitup/screens/components/custom_text_button.dart';
import 'package:topitup/screens/components/custom_text_form_field.dart';
import 'package:topitup/services/networking/web_api/cable_api.dart';
import 'package:topitup/utils/snackbar.dart';

class CableScreen extends StatefulWidget {
  const CableScreen({Key? key}) : super(key: key);

  static const String id = 'cable tv screen';

  @override
  State<CableScreen> createState() => _CableScreenState();
}

class _CableScreenState extends State<CableScreen> {
  bool _isLoading = false;
  final _smartCardNumberController = TextEditingController();

  late final List<SubServiceModel> _tvCables = [];

  List<DropdownMenuItem<String>> packages = [
    const DropdownMenuItem(value: 'dstv', child: Text('DSTV')),
    const DropdownMenuItem(value: 'startimes', child: Text('Startimes')),
    const DropdownMenuItem(value: 'gotv', child: Text('Go tv')),
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
              screenName: 'Cable TV',
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding.w / 2,
                  vertical: kDefaultPadding.h,
                ),
                child: SingleChildScrollView(
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
                        items: _tvCables
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
                        selectedItem: (selectedItem) {},
                        hintText: _tvCables.isEmpty
                            ? 'Loading...'
                            : 'Select provider',
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
                        items: packages,
                        selectedItem: (selectedItem) {},
                        hintText: 'Select provider',
                      ),
                      SizedBox(
                        height: kDefaultPadding.h * 2,
                      ),
                      CustomTextButton(
                        text: 'Pay: ₦0.00',
                        onPressed: () {
                          // _submitPayment(
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
        apiKey: context.read<ApiKey>().getApiKey,
        deviceId: context.read<DeviceInfo>().getDeviceId);
    super.initState();
  }

  @override
  void dispose() {
    _smartCardNumberController.dispose();
    super.dispose();
  }

  Future<void> _getCableSubscriptions(
      {required String apiKey, required String deviceId}) async {
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
        _tvCables.clear();
        // _availableServices.clear();
        _tvCables.addAll(loadedSubservices);
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
