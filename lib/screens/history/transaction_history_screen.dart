import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Transaction History'),
        centerTitle: true,
      ),
      body: Padding(
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
              height: kDefaultPadding.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) =>
                    const CustomTransactionHistoryCard(
                  transactionTypeImage: 'assets/svg/top-up-card.svg',
                  transactionTypelabel: 'Top-up',
                  transactionDate: 'August 29, 11:30',
                  transactionAmount: '₦100000',
                  transactionPayStatus: 'Done',
                  transactionStatusColour: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
