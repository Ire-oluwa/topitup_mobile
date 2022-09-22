import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_constants.dart';
import '../../components/custom_text.dart';

class ChooseAirtimeAmountWidget extends StatelessWidget {
  const ChooseAirtimeAmountWidget({
    Key? key,
    required this.amount,
    required this.onAdd,
    required this.onSubtract,
  }) : super(key: key);

  final String amount;
  final Function() onAdd, onSubtract;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(
            text: 'Amount',
            textColor: kPrimaryColour,
            textSize: 20.sp,
            fontWeight: FontWeight.w300,
            fontFamily: 'Montserrat',
            alignText: TextAlign.center,
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: onSubtract,
                icon: SvgPicture.asset('assets/svg/subtract-alt.svg'),
              ),
              CustomText(
                text: amount,
                textSize: 36.0.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                textColor: kPrimaryColour,
              ),
              IconButton(
                onPressed: onAdd,
                icon: SvgPicture.asset('assets/svg/add-alt.svg'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
