import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_constants.dart';
import '../bottom_navigation/bottom_navigation_bar.dart';
import '../components/custom_text.dart';
import '../components/custom_dashboard_feature_icon_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  static const String id = 'services screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Services',
          textSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding.h + 10,
          horizontal: kDefaultPadding.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDashboardFeatureIconCard(
                  icon: 'assets/svg/airtime-icon.svg',
                  label: 'Buy Airtime',
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    BottomNavBar.data,
                  ),
                ),
                CustomDashboardFeatureIconCard(
                  icon: 'assets/svg/data-icon.svg',
                  label: 'Buy Data',
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    BottomNavBar.data,
                  ),
                ),
                CustomDashboardFeatureIconCard(
                  icon: 'assets/svg/internet-icon.svg',
                  label: 'Internet',
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    BottomNavBar.internet,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: kDefaultPadding.h * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDashboardFeatureIconCard(
                  icon: 'assets/svg/cable-icon.svg',
                  label: 'Cable Tv',
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    BottomNavBar.cable,
                  ),
                ),
                CustomDashboardFeatureIconCard(
                  icon: 'assets/svg/electricity-icon.svg',
                  label: 'Pay Electric Bills',
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    BottomNavBar.electricity,
                  ),
                ),
                CustomDashboardFeatureIconCard(
                  icon: 'assets/svg/wallet-close-icon.svg',
                  label: 'Wallet',
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: kDefaultPadding.h * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDashboardFeatureIconCard(
                  icon: 'assets/svg/education-icon.svg',
                  label: 'Education',
                  onPressed: () {},
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
