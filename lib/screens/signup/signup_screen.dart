import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../providers/device_info_provider.dart';
import '../../services/networking/web_api/user_api.dart';
import '../../utils/snackbar.dart';
import '../../constants/app_constants.dart';
import '../components/custom_auth_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String id = 'signup screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;
  final _signupFormKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isPhoneNumberValid = false;
  String _normalizedPhoneNumber = '';
  RegionInfo? _regionInfo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: LoadingOverlay(
            isLoading: _isLoading,
            child: CustomAuthScreenBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding.w,
                    vertical: kDefaultPadding.h * 2.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: '  Create your account',
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        textSize: 20.0.sp,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: kDefaultPadding.h / 2,
                      ),
                      SizedBox(
                        height: size.height * 0.78,
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(
                              kDefaultPadding,
                            ),
                          ),
                          child: Form(
                            key: _signupFormKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding.w - 5,
                                vertical: kDefaultPadding.h + 10,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomText(
                                      text: 'Use your personal information',
                                      textSize: 16.0.sp,
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h + 10,
                                    ),
                                    CustomTextFormField(
                                      controller: _firstNameController,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.next,
                                      placeholder: 'First Name',
                                      validate: kRequiredField,
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h / 2,
                                    ),
                                    CustomTextFormField(
                                      controller: _lastNameController,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.next,
                                      placeholder: 'Last Name',
                                      validate: kRequiredField,
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h / 2,
                                    ),
                                    CustomTextFormField(
                                      controller: _usernameController,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.next,
                                      placeholder: 'Username',
                                      validate: kRequiredField,
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h / 2,
                                    ),
                                    CustomTextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      inputAction: TextInputAction.next,
                                      placeholder: 'Email Address',
                                      validate: kEmailValidator,
                                      textCapitalization:
                                          TextCapitalization.none,
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h / 2,
                                    ),
                                    InternationalPhoneNumberInput(
                                      textFieldController:
                                          _phoneNumberController,
                                      onInputChanged: (PhoneNumber number) {
                                        _validatePhoneNumber();
                                      },
                                      inputDecoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 1.0,
                                          horizontal: 8.0,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffE6ECFA),
                                        border: OutlineInputBorder(),
                                        hintText: 'Phone Number',
                                      ),
                                      selectorConfig: const SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.DIALOG,
                                        setSelectorButtonAsPrefixIcon: true,
                                        leadingPadding: 10.0,
                                      ),
                                      validator: kRequiredField,
                                      keyboardAction: TextInputAction.next,
                                      spaceBetweenSelectorAndTextField: 3.0.w,
                                      countries: const ['NG'],
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h / 2,
                                    ),
                                    CustomTextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      placeholder: '********',
                                      textCapitalization:
                                          TextCapitalization.none,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      inputAction: TextInputAction.done,
                                      validate: kPasswordValidator,
                                      suffixIcon: IconButton(
                                        icon: FaIcon(
                                          _obscurePassword == false
                                              ? FontAwesomeIcons.solidEyeSlash
                                              : FontAwesomeIcons.solidEye,
                                          size: kDefaultIconSize.sp,
                                        ),
                                        onPressed: () => setState(
                                          () {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h + 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: kDefaultPadding.w * 7.5,
                                      ),
                                      child: CustomTextButton(
                                        text: 'Register',
                                        onPressed: () => _submitSignup(context),
                                        backgroundColour: kSecondaryColour,
                                        borderColour: Colors.transparent,
                                        textColour: Colors.white,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: kDefaultPadding.h,
                                    // ),
                                    // const LoginFormSectionDivider(),
                                    const SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Row(
                                      children: [
                                        const CustomText(
                                          text: 'Already have an account? ',
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushReplacementNamed(
                                            LoginScreen.id,
                                          ),
                                          child: const CustomText(
                                            text: 'Sign in',
                                            textColor: kSecondaryColour,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 8.h,
                                    // ),
                                    // const LoginFormSectionDivider(),
                                    // SizedBox(
                                    //   height: 5.h,
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //     right: kDefaultPadding.w * 5,
                                    //   ),
                                    //   child: TextButton.icon(
                                    //     onPressed: () {},
                                    //     icon: Image.asset(
                                    //       'assets/logos/google-logo.png',
                                    //       fit: BoxFit.fitHeight,
                                    //     ),
                                    //     label: const CustomText(
                                    //       text: 'Sign in with Google',
                                    //     ),
                                    //     style: TextButton.styleFrom(
                                    //       backgroundColor:
                                    //           // ignore: use_full_hex_values_for_flutter_colors
                                    //           const Color(0xff22347f3b),
                                    //       primary: Colors.black,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitSignup(BuildContext context) async {
    if (_signupFormKey.currentState!.validate()) {
      if (_isPhoneNumberValid) {
        await _signupUser(context);
        return;
      }
      displaySnackbar(
        context,
        'Invalid phone number',
      );
      return;
    }
    displaySnackbar(
      context,
      'Fill in the form properly!',
    );
  }

  Future<void> _signupUser(BuildContext context) async {
    _makeLoadingTrue();
    final deviceId = context.read<DeviceInfo>().getDeviceId;
    final res = await UserApi.createUser(
      deviceId: deviceId,
      username: _usernameController.text,
      email: _emailController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _normalizedPhoneNumber,
      password: _passwordController.text,
    );

    if (res.statusCode == 200) {
      _makeLoadingFalse();
      final data = jsonDecode(res.body);
      if (data['status'] == 1) {
        // SecureStorage.setUserApiKey(data['api_key']);
        if (!mounted) return;
        _makeLoadingFalse();
        displaySnackbar(
          context,
          'Registration Successful, Please Login',
        );
        Navigator.of(context).pushReplacementNamed(LoginScreen.id);
        return;
      }
      _makeLoadingFalse();
      if (!mounted) return;
      displaySnackbar(
        context,
        'Username or Email already exists!',
      );
      return;
    }
    _makeLoadingFalse();
    if (!mounted) return;
    displaySnackbar(
      context,
      'Error occured! Try again later.',
    );
  }

  _validatePhoneNumber() async {
    try {
      var s = _phoneNumberController.text;
      bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
          phoneNumber: s, isoCode: 'NG');
      String? normalizedNumber = await PhoneNumberUtil.normalizePhoneNumber(
          phoneNumber: s, isoCode: 'NG');
      RegionInfo regionInfo =
          await PhoneNumberUtil.getRegionInfo(phoneNumber: s, isoCode: 'NG');
      setState(() {
        _isPhoneNumberValid = isValid ?? false;
        _normalizedPhoneNumber = normalizedNumber ?? "N/A";
        _regionInfo = regionInfo;
      });
    } catch (e) {
      print(e);
    }
  }

  void _makeLoadingFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  void _makeLoadingTrue() {
    setState(() {
      _isLoading = true;
    });
  }
}
