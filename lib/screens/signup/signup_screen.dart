import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/screens/components/custom_auth_screen_background.dart';
import 'package:topitup/screens/components/custom_text.dart';
import 'package:topitup/screens/components/custom_text_button.dart';
import 'package:topitup/screens/components/custom_text_form_field.dart';
import 'package:topitup/screens/components/login_form_section_divider.dart';
import 'package:topitup/screens/login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String id = 'signup screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  height: kDefaultPadding.h,
                                ),
                                CustomTextFormField(
                                  controller: _lastNameController,
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                  placeholder: 'Last Name',
                                  validate: kRequiredField,
                                ),
                                SizedBox(
                                  height: kDefaultPadding.h,
                                ),
                                CustomTextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  placeholder: 'Email Address',
                                  validate: kEmailValidator,
                                  textCapitalization: TextCapitalization.none,
                                ),
                                SizedBox(
                                  height: kDefaultPadding.h,
                                ),
                                CustomTextFormField(
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  inputAction: TextInputAction.done,
                                  placeholder: 'Phone Number',
                                  validate: kRequiredField,
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
                                  height: kDefaultPadding.h * 2,
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
                                SizedBox(
                                  height: 8.h,
                                ),
                                const LoginFormSectionDivider(),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: kDefaultPadding.w * 5,
                                  ),
                                  child: TextButton.icon(
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
                                ),
                              ],
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
}
