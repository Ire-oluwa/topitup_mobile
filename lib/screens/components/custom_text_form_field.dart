import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:topitup/constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.placeholder,
    required this.keyboardType,
    required this.inputAction,
    this.validate,
    this.enabled,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon,
    this.onKeyUp,
  }) : super(key: key);

  final TextEditingController controller;
  final String? placeholder;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String>? validate;
  final bool? enabled;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Function(String)? onKeyUp;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onKeyUp,
      // onEditingComplete: onCompleteEdit,
      controller: controller,
      validator: validate,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: const Color(0xffE6ECFA),
        contentPadding: EdgeInsets.symmetric(
          vertical: 5.0.h,
          horizontal: 12.0.w,
        ),
        hintText: placeholder,
        border: OutlineInputBorder(
          borderSide: kLightBorderSide.copyWith(
            color: const Color(0xffE6ECFA),
            width: 0.0,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      enabled: enabled,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
    );
  }
}
