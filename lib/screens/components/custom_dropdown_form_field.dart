import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/screens/components/custom_text.dart';


class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    this.fieldTitle,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> items;
  final Function(String?) selectedItem;
  final String hintText;
  final String? fieldTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        fieldTitle != null
            ? CustomText(
                text: fieldTitle!,
                fontFamily: 'Montserrat',
                textSize: 12.0.sp,
                fontWeight: FontWeight.w500,
              )
            : Container(),
        fieldTitle != null
            ? SizedBox(
                height: 5.h,
              )
            : Container(),
        DropdownButtonFormField<String>(
          items: items,
          onChanged: selectedItem,
          decoration: kDropdownFieldDecoration.copyWith(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                5.0,
              ),
              borderSide: kLightBorderSide,
            ),
          ),
        ),
      ],
    );
  }
}