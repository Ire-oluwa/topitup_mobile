import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topitup/screens/bottom_navigation/bottom_navigation_bar.dart';
import 'package:topitup/screens/cable/cable_screen.dart';
import 'package:topitup/screens/data/data_screen.dart';
import 'package:topitup/screens/electricity/electricity_screen.dart';
import 'package:topitup/screens/internet/internet_screen.dart';
import 'providers/device_info_provider.dart';
import 'screens/dashboard/dashboard_screen.dart';

import 'constants/palette.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DeviceInfo(),
        ),
      ],
      child: const TopitupNg(),
    ),
  );
}

class TopitupNg extends StatelessWidget {
  const TopitupNg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(414.0, 896.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (child, _) => MaterialApp(
        title: 'TopitupNG',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette.kCustomColour,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color(0XFFF1F9FF),
          fontFamily: 'SF-Pro-Text',
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontSize: 14.0.sp,
            ),
          ),
        ),
        initialRoute: DashboardScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          OnboardingScreen.id: (context) => const OnboardingScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignupScreen.id: (context) => const SignupScreen(),
          BottomNavBar.home: (context) => const BottomNavBar(screenIndex: 0),
          BottomNavBar.internet: (context) =>
              const BottomNavBar(screenIndex: 1),
          BottomNavBar.data: (context) => const BottomNavBar(screenIndex: 2),
          BottomNavBar.electricity: (context) =>
              const BottomNavBar(screenIndex: 3),
          BottomNavBar.cable: (context) => const BottomNavBar(screenIndex: 4),
          DashboardScreen.id: (context) => const DashboardScreen(),
          InternetScreen.id: (context) => const InternetScreen(),
          DataScreen.id: (context) => const DataScreen(),
          ElectricityScreen.id: (context) => const ElectricityScreen(),
          CableScreen.id: (context) => const CableScreen(),
        },
      ),
    );
  }
}
