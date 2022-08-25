import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_constants.dart';
import '../components/custom_auth_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';
import 'components/login_form_section_divider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: CustomAuthScreenBackground(
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height * 0.92,
                child: Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.6,
                      child: Card(
                        margin: EdgeInsets.fromLTRB(
                          kDefaultPadding.w + 10,
                          kDefaultPadding.h * 3,
                          kDefaultPadding.w + 10,
                          0.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            kDefaultPadding + 10,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            kDefaultPadding.w,
                            kDefaultPadding.h + 5,
                            kDefaultPadding.h,
                            0.0,
                          ),
                          child: Form(
                            key: _loginFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomText(
                                  text: 'Hello! Welcome back',
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  textSize: 20.sp,
                                  textColor: kPrimaryColour,
                                ),
                                SizedBox(
                                  height: kDefaultPadding.h + 10,
                                ),
                                const CustomText(text: 'Username'),
                                SizedBox(
                                  height: 5.0.h,
                                ),
                                CustomTextFormField(
                                  controller: _userNameController,
                                  placeholder: 'Khalifa',
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                  validate: kRequiredField,
                                ),
                                SizedBox(
                                  height: kDefaultPadding.h,
                                ),
                                const CustomText(text: 'Password'),
                                SizedBox(
                                  height: 5.0.h,
                                ),
                                CustomTextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  placeholder: '********',
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.visiblePassword,
                                  inputAction: TextInputAction.done,
                                  validate: kPasswordValidator,
                                  suffixIcon: IconButton(
                                    icon: FaIcon(
                                      _obscurePassword == false
                                          ? FontAwesomeIcons.solidEyeSlash
                                          : FontAwesomeIcons.solidEye,
                                      size: kDefaultIconSize.sp,
                                    ),
                                    onPressed: () => setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: kDefaultPadding.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120.w,
                                      child: CustomTextButton(
                                        text: 'Login',
                                        onPressed: () {},
                                        backgroundColour: kSecondaryColour,
                                        borderColour: Colors.transparent,
                                        textColour: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const CustomText(
                                        text: 'Forgot Password?',
                                        textColor: kSecondaryColour,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                const LoginFormSectionDivider(),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/logos/google-logo.png',
                                        fit: BoxFit.fitHeight,
                                      ),
                                      label: const CustomText(
                                        text: 'Sign in with Google',
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            // ignore: use_full_hex_values_for_flutter_colors
                                            const Color(0xff22347f3b),
                                        primary: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: kDefaultPadding.w + 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        'assets/svg/biometric.svg',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPadding.h - 5,
                                ),
                                Row(
                                  children: [
                                    const CustomText(
                                        text: 'New to Topitupng? '),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const CustomText(
                                        text: 'Sign up here.',
                                        textColor: kSecondaryColour,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 35.h,
                      right: 5.w,
                      child: Image.asset(
                        'assets/young_man.png',
                      ),
                    ),
                  ],
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
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
