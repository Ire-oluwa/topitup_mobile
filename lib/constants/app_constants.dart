import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const kPrimaryColour = Color(0XFF22347F);
const kSecondaryColour = Color(0xff28C0F1);
const kDefaultIconSize = 18.0;
const kDefaultPadding = 20.0;
const kLightBorderSide = BorderSide(width: 1.0, color: Colors.black12);
final kEmailValidator = MultiValidator([
  RequiredValidator(errorText: '* Required'),
  PatternValidator(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
      errorText: 'Enter a valid email address')
]);
final kPasswordValidator = MultiValidator([
  RequiredValidator(errorText: '* Required'),
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  //PatternValidator(r'^(?=.*[0-9]+.*)(?=.*[A-Z]+.*)(?=.*[a-z]+.*)[0-9a-zA-Z]+$',
  //  errorText: 'Must contain a digit, lowercase & uppercase character')
]);
final kRequiredField = RequiredValidator(errorText: '* Required');
const kDropdownFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: 5.0,
    horizontal: 8.0,
  ),
  hintText: 'Select data',
);
