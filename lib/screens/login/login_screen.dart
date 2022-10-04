import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../providers/api_key_provider.dart';
import '../../providers/device_info_provider.dart';
import '../../services/networking/web_api/user_api.dart';
import '../../services/secure_storage/secure_storage.dart';
import '../../utils/snackbar.dart';
import '../components/custom_auth_screen_background.dart';
import '../components/custom_text.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form_field.dart';
import '../dashboard/dashboard_screen.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final LocalAuthentication auth = LocalAuthentication();

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
                child: SizedBox(
                  height: size.height * 0.95,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.65,
                        child: Card(
                          elevation: 1,
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
                                    validate: kRequiredField,
                                    suffixIcon: IconButton(
                                      icon: FaIcon(
                                        _obscurePassword == false
                                            ? FontAwesomeIcons.solidEye
                                            : FontAwesomeIcons.solidEyeSlash,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 120.w,
                                        height: 50.h,
                                        child: CustomTextButton(
                                          text: 'Login',
                                          onPressed: () =>
                                              _submitLogin(context),
                                          backgroundColour: kSecondaryColour,
                                          borderColour: Colors.transparent,
                                          textColour: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      IconButton(
                                        onPressed: () async =>
                                            await _biometricLogin(context),
                                        icon: SvgPicture.asset(
                                          'assets/svg/biometric.svg',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: kDefaultPadding.h,
                                  ),
                                  GestureDetector(
                                    //TODO: navigate to forgot password screen.
                                    onTap: () {},
                                    child: const CustomText(
                                      text: 'Forgot Password?',
                                      textColor: kSecondaryColour,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 8.h,
                                  // ),
                                  // const LoginFormSectionDivider(),
                                  // SizedBox(
                                  //   height: 2.h,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     TextButton.icon(
                                  //       onPressed: () {},
                                  //       icon: Image.asset(
                                  //         'assets/logos/google-logo.png',
                                  //         fit: BoxFit.fitHeight,
                                  //       ),
                                  //       label: const CustomText(
                                  //         text: 'Sign in with Google',
                                  //       ),
                                  //       style: TextButton.styleFrom(
                                  //         backgroundColor:
                                  //             // ignore: use_full_hex_values_for_flutter_colors
                                  //             const Color(0xff22347f3b),
                                  //         primary: Colors.black,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: kDefaultPadding.w + 10,
                                  //     ),
                                  //     GestureDetector(
                                  //       onTap: () {},
                                  //       child: SvgPicture.asset(
                                  //         'assets/svg/biometric.svg',
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: kDefaultPadding.h - 5,
                                  ),
                                  Row(
                                    children: [
                                      const CustomText(
                                          text: 'New to Topitupng? '),
                                      GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushReplacementNamed(
                                          SignupScreen.id,
                                        ),
                                        child: const CustomText(
                                          text: 'Sign up here',
                                          textColor: kSecondaryColour,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25.h,
                        right: -15.w,
                        child: SizedBox(
                          height: size.height * 0.4,
                          child: Image.asset(
                            'assets/young_man.png',
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
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin(BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      await _loginUser(context);
      return;
    }
    displaySnackbar(
      context,
      'Fill in the form properly!',
    );
  }

  Future<void> _biometricLogin(BuildContext context) async {
    final userName = await SecureStorage.currentLoginUsername();
    final password = await SecureStorage.currentLoginPassword();
    if (userName != null &&
        userName != "" &&
        password != null &&
        password != "") {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      final availableBiometrics = await auth.getAvailableBiometrics();
      if (canAuthenticate && availableBiometrics.isNotEmpty) {
        bool didAuthenticate = false;
        try {
          didAuthenticate = await auth.authenticate(
              localizedReason:
                  'Please authenticate with Fingerprint or Face ID to proceed with login',
              options: const AuthenticationOptions(
                  biometricOnly: true, stickyAuth: true));
        } on PlatformException catch (e) {
          debugPrint(e.toString());
          // if (e.code == auth_error.notAvailable ||
          //     e.code == auth_error.notEnrolled) {}
        }
        if (didAuthenticate) {
          _userNameController.text = userName;
          _passwordController.text = password;
          if (!mounted) return;
          await _loginUser(context);
          return;
        }
        if (!mounted) return;
        displaySnackbar(
          context,
          'Invalid credentials',
        );
        return;
      }
      if (!mounted) return;
      displaySnackbar(
        context,
        'Biometric Authorization not Available',
      );
      return;
    }
    if (!mounted) return;
    _submitLogin(context);
    // displaySnackbar(
    //   context,
    //   'First time login requires filling the form.',
    // );
  }

  Future<void> _loginUser(BuildContext context) async {
    _makeLoadingTrue();
    final deviceId = context.read<DeviceInfo>().getDeviceId;
    final res = await UserApi.loginUser(
      userName: _userNameController.text,
      password: _passwordController.text,
      deviceId: deviceId,
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      // print(data);
      if (data['status'] == 1) {
        if (data['api_key'] != "") {
          if (!mounted) return;

          SecureStorage.setUserApiKey(data['api_key']);
          SecureStorage.setLoginUsername(_userNameController.text);
          SecureStorage.setLoginPassword(_passwordController.text);
          context.read<ApiKey>().apiKey = data['api_key'];
          _makeLoadingFalse();
          Navigator.of(context).pushNamedAndRemoveUntil(
            DashboardScreen.id,
            (route) => false,
            arguments: data['name'],
          );
          return;
        }
        _makeLoadingFalse();
        if (!mounted) return;
        displaySnackbar(
          context,
          'Login Not Successful.',
        );
        return;
      }
      _makeLoadingFalse();
      if (!mounted) return;
      displaySnackbar(
        context,
        'Invalid credentials.',
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
