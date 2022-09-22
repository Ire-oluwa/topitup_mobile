import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_text.dart';

class NetworkProviderCardIcon extends StatelessWidget {
  const NetworkProviderCardIcon({
    Key? key,
    required this.networkProviderLogo,
    required this.onPressed,
    required this.serviceName,
  }) : super(key: key);

  final String networkProviderLogo, serviceName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  100,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  3.w,
                ),
                child: Image.asset(
                  networkProviderLogo,
                  width: 50.w,
                  height: 55.h,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            FittedBox(
              child: CustomText(
                text: serviceName,
                alignText: TextAlign.center,
                textSize: 12.0.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
