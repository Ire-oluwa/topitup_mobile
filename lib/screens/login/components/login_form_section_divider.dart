import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_constants.dart';
import '../../components/custom_text.dart';

class LoginFormSectionDivider extends StatelessWidget {
  const LoginFormSectionDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: kDefaultPadding.w + 10,
          child: const Divider(
            thickness: 2,
            color: Colors.black,
          ),
        ),
        const CustomText(text: ' or '),
        SizedBox(
          width: kDefaultPadding.w + 10,
          child: const Divider(
            thickness: 2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
