import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/main_service.dart';
import '../../providers/api_key_provider.dart';
import '../../providers/device_info_provider.dart';
import '../../providers/electricity_provider.dart';
import '../../services/networking/web_api/elactricity_api.dart';
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
  final String _paymentPrice = '0.00';

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
                              modalBottomSheetProps:
                                  const ModalBottomSheetProps(
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
                              print(selectedDistribution.serviceCode);
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
        // _availableServices.clear();
        // _availableServices = [
        //   AvailableServiceModel(name: 'Choose package', systemName: '')
        // ];
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
