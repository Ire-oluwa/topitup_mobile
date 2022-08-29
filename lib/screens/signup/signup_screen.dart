import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:topitup/providers/device_info_provider.dart';
import 'package:topitup/screens/components/login_form_section_divider.dart';
import 'package:topitup/services/networking/web_api/user_api.dart';
import 'package:topitup/utils/snackbar.dart';
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
                                    CustomTextFormField(
                                      controller: _phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      inputAction: TextInputAction.next,
                                      placeholder: 'Phone Number',
                                      validate: kRequiredField,
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h / 2,
                                    ),
                                    CustomTextFormField(
                                      controller: _passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      inputAction: TextInputAction.done,
                                      placeholder: 'Password',
                                      validate: kPasswordValidator,
                                      textCapitalization:
                                          TextCapitalization.none,
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
                                        onPressed: () {},
                                        backgroundColour: kSecondaryColour,
                                        borderColour: Colors.transparent,
                                        textColour: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding.h,
                                    ),
                                    const LoginFormSectionDivider(),
                                    const SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Row(
                                      children: [
                                        const CustomText(
                                            text: 'Already have an account? '),
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
    super.dispose();
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
