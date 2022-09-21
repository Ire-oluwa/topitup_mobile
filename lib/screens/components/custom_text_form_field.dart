import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: const Color(0xffE6ECFA),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.0.h,
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
