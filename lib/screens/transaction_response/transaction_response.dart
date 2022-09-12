import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_constants.dart';
import '../components/custom_text.dart';

class TransactionResponseScreen extends StatelessWidget {
  const TransactionResponseScreen({super.key});
  static const String id = 'transaction response';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColour,
      appBar: AppBar(
        title: CustomText(
          text: 'Transaction Details',
          fontFamily: 'Montserrat',
          textSize: 22.sp,
        ),
        elevation: 0.0,
      ),
    );
  }
}
