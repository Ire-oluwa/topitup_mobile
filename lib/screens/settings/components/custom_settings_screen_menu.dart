import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_constants.dart';
import '../../components/custom_text.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({
    Key? key,
    required this.iconPath,
    required this.menuLabel,
    required this.onPressed,
  }) : super(key: key);

  final String iconPath, menuLabel;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        width: 30.w,
        height: 30.h,
      ),
      title: CustomText(
        text: menuLabel,
        textColor: kPrimaryColour,
      ),
      onTap: onPressed,
    );
  }
}
