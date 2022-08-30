import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(create: (_) => DeviceInfo()),
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
          // scaffoldBackgroundColor: const Color(0xFFFCFCFC),
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
          DashboardScreen.id: (context) => const DashboardScreen(),
        },
      ),
    );
  }
}
