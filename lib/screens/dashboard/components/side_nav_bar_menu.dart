import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_constants.dart';
import '../../components/custom_text.dart';

class SideNavBarMenu extends StatelessWidget {
  const SideNavBarMenu({
    Key? key,
    required this.iconName,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String iconName, label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconName,
        width: kDefaultIconSize.w,
        height: kDefaultIconSize.h,
      ),
      title: CustomText(
        text: label,
        textColor: kPrimaryColour,
      ),
      horizontalTitleGap: 1.w,
      onTap: onPressed,
    );
  }
}