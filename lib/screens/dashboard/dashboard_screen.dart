import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topitup/constants/app_constants.dart';
import 'package:topitup/screens/bottom_navigation/bottom_navigation_bar.dart';
import 'package:topitup/screens/cable/cable_screen.dart';
import 'package:topitup/screens/components/custom_text.dart';
import 'package:topitup/screens/dashboard/components/custom_dashboard_feature_icon_card.dart';
import 'package:topitup/screens/dashboard/components/dashboard_header_profile_details_section.dart';
import 'package:topitup/screens/dashboard/components/dashboard_header_transaction_details_card.dart';
import 'package:topitup/screens/data/data_screen.dart';
import 'package:topitup/screens/electricity/electricity_screen.dart';
import 'package:topitup/screens/internet/internet_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const String id = 'dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final user = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'John Williams',
                        textSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        textColor: kPrimaryColour,
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          size: kDefaultIconSize.sp,
                          color: const Color(0xff3A3A3A),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const CustomText(
                    text: 'My Account',
                    textColor: kSecondaryColour,
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 18.0.sp,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: size.height * 0.40,
                child: Stack(
                  children: [
                    Container(
                      color: kPrimaryColour,
                      height: size.height * 0.20,
                      padding: EdgeInsets.all(1.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: kDefaultPadding.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding.w * 2,
                            ),
                            child: const DashboardHeaderProfileDetailsSection(
                              userFirstName: 'John',
                              userProfileImage: 'assets/marston.jpeg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 150.h,
                      left: 30.w,
                      right: 30.w,
                      child: Center(
                        child: SizedBox(
                          width: size.width * 0.8,
                          child: const DashboardHeaderTransactionDetailsCard(
                            walletAmount: '10,000,000',
                            cashbackAmount: '20.00',
                            voucherAmount: '0',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: kDefaultPadding.h * 2,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/airtime-icon.svg',
                          label: 'Buy Airtime',
                          onPressed: () => Navigator.of(context).pushNamed(
                            DataScreen.id,
                          ),
                        ),
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/data-icon.svg',
                          label: 'Buy Data',
                          onPressed: () => Navigator.of(context).pushNamed(
                            DataScreen.id,
                          ),
                        ),
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/internet-icon.svg',
                          label: 'Internet',
                          onPressed: () => Navigator.of(context).pushNamed(
                            InternetScreen.id,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding.h * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/cable-icon.svg',
                          label: 'Cable Tv',
                          onPressed: () => Navigator.of(context).pushNamed(
                            CableScreen.id,
                          ),
                        ),
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/electricity-icon.svg',
                          label: 'Pay Electric Bills',
                          onPressed: () => Navigator.of(context).pushNamed(
                            ElectricityScreen.id,
                          ),
                        ),
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/others.svg',
                          label: 'Others',
                          onPressed: () => Navigator.of(context).pushNamed(
                            ElectricityScreen.id,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22.0),
          topRight: Radius.circular(22.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: kPrimaryColour,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/home-icon.svg',
                iconColour: kSecondaryColour,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Internet',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/internet-icon.svg',
                iconColour: Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Data',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/data-icon.svg',
                iconColour: Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Electricity',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/electricity-icon.svg',
                iconColour: Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Cable Tv',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/cable-icon.svg',
                iconColour: Colors.grey,
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (selectedIndex) => _onItemTapped(context, selectedIndex),
        ),
      ),
    );
  }

  _onItemTapped(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
      _selectedIndex == 0
          ? Navigator.of(context).pushReplacementNamed(DashboardScreen.id)
          : _selectedIndex == 1
              ? Navigator.of(context).pushNamed(InternetScreen.id)
              : _selectedIndex == 2
                  ? Navigator.of(context).pushNamed(DataScreen.id)
                  : _selectedIndex == 3
                      ? Navigator.of(context).pushNamed(ElectricityScreen.id)
                      : _selectedIndex == 4
                          ? Navigator.of(context).pushNamed(CableScreen.id)
                          : null;
    });
  }
}
