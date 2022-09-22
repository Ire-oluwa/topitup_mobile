import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../extensions/string_extension.dart';
import '../../models/recharge_history.dart';
import '../../providers/api_key_provider.dart';
import '../../providers/device_info_provider.dart';
import '../../services/networking/web_api/transaction_history_api.dart';
import '../components/custom_text.dart';
import '../components/custom_text_form_field.dart';
import '../components/custom_transaction_history_card.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  static const String id = 'transaction history screen';

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final _searchController = TextEditingController();
  late Future<List<RechargeHistoryModel>> _getAllRechargeHistories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Transaction History'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshTransactionHistories(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding.w - 5,
            vertical: kDefaultPadding.h + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.search,
                suffixIcon: const Icon(Icons.search),
              ),
              SizedBox(
                height: kDefaultPadding.h,
              ),
              CustomText(
                text: 'Recent Transactions',
                textSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                textColor: const Color(0xff605A5A),
              ),
              SizedBox(
                height: kDefaultPadding.h / 2,
              ),
              Expanded(
                child: FutureBuilder<List<RechargeHistoryModel>>(
                  future: _getAllRechargeHistories,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      final trxHistories = snapshot.data!;
                      return ListView.builder(
                        itemCount: trxHistories.length,
                        itemBuilder: (context, index) =>
                            CustomTransactionHistoryCard(
                          transactionTypeImage:
                              trxHistories[index].serviceName!.contains('data')
                                  ? 'assets/svg/covered-data-icon.svg'
                                  : trxHistories[index]
                                              .serviceName!
                                              .contains('mtn') ||
                                          trxHistories[index]
                                              .serviceName!
                                              .contains('glo') ||
                                          trxHistories[index]
                                              .serviceName!
                                              .contains('airtel') ||
                                          trxHistories[index]
                                              .serviceName!
                                              .contains('9mobile')
                                      ? 'assets/svg/covered-airtime-icon.svg'
                                      : 'assets/svg/covered-top-up-card.svg',
                          transactionTypelabel: trxHistories[index]
                              .serviceName!
                              .replaceAll('_', ' ')
                              .capitalize(),
                          transactionDate: trxHistories[index].dateAdded!,
                          transactionAmount: '₦${trxHistories[index].amount!}',
                          transactionPayStatus: trxHistories[index].payStatus!,
                          transactionStatusColour:
                              trxHistories[index].payStatus == 'Done'
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return const Center(
                        child: Text('No data'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _getAllRechargeHistories = _getRechargeHistories(context,
        apiKey: context.read<ApiKey>().getApiKey,
        deviceId: context.read<DeviceInfo>().getDeviceId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshTransactionHistories(BuildContext context) async {
    _getAllRechargeHistories = _getRechargeHistories(context,
        apiKey: context.read<ApiKey>().getApiKey,
        deviceId: context.read<DeviceInfo>().getDeviceId);
  }

  Future<List<RechargeHistoryModel>> _getRechargeHistories(BuildContext context,
      {required String apiKey, required String deviceId}) async {
    final res = await TransactionHistoryApi.rechargeHistory(
        apiKey: apiKey, deviceId: deviceId);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      List<RechargeHistoryModel> rechargeHistories = data['data_result']
          .map<RechargeHistoryModel>(RechargeHistoryModel.fromJson)
          .toList();
      return rechargeHistories;
    }
    return [];
  }
}
