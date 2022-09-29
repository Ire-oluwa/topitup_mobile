import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'providers/electricity_provider.dart';

import 'constants/app_constants.dart';
import 'constants/palette.dart';
import 'providers/api_key_provider.dart';
import 'providers/device_info_provider.dart';
import 'providers/tv_provider.dart';
import 'providers/wallet_balance_provider.dart';
import 'screens/about/about_screen.dart';
import 'screens/bottom_navigation/bottom_navigation_bar.dart';
import 'screens/cable/cable_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/data/data_screen.dart';
import 'screens/electricity/electricity_screen.dart';
import 'screens/help/help_screen.dart';
import 'screens/history/transaction_history_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/internet/internet_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/services/services_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/transaction_response/transaction_response_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColour,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DeviceInfo(),
        ),
        ChangeNotifierProvider(
          create: (_) => ApiKey(),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletBalance(),
        ),
        ChangeNotifierProvider(
          create: (_) => TvCable(),
        ),
        ChangeNotifierProvider(
          create: (_) => Electricity(),
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
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          OnboardingScreen.id: (context) => const OnboardingScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignupScreen.id: (context) => const SignupScreen(),
          // BottomNavBar.home: (context) => const BottomNavBar(screenIndex: 0),
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
          TransactionResponseScreen.id: (context) =>
              const TransactionResponseScreen(),
          ServicesScreen.id: (context) => const ServicesScreen(),
          TransactionHistoryScreen.id: (context) =>
              const TransactionHistoryScreen(),
          SettingsScreen.id: (context) => const SettingsScreen(),
          HelpScreen.id: (context) => const HelpScreen(),
          AboutScreen.id: (context) => const AboutScreen(),
        },
      ),
    );
  }
}
