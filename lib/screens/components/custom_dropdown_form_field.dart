import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import 'custom_text.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    this.fieldTitle,
    this.validate,
    this.selectedValue,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> items;
  final Function(String?) selectedItem;
  final String hintText;
  final String? fieldTitle, selectedValue;
  final FormFieldValidator<String>? validate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldTitle != null
            ? CustomText(
                text: fieldTitle ?? '',
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
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
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
            validator: validate,
          ),
        ),
      ],
    );
  }
}
