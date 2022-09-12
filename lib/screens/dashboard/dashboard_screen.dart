import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/app_constants.dart';
import '../bottom_navigation/bottom_navigation_bar.dart';
import '../components/custom_text.dart';
import 'components/custom_dashboard_feature_icon_card.dart';
import 'components/dashboard_header_profile_details_section.dart';
import 'components/dashboard_header_transaction_details_card.dart';
import '../electricity/electricity_screen.dart';

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
              decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(
                    context,
                    color: kSecondaryColour,
                    width: 1.0.w,
                  ),
                ),
              ),
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
                    text: 'My Profile',
                    textColor: kSecondaryColour,
                  ),
                ],
              ),
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/wallet-icon.svg',
              label: 'Wallet',
              onPressed: () {},
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/wallet-funds-icon.svg',
              label: 'Send wallet funds',
              onPressed: () {},
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/services-icon.svg',
              label: 'Services',
              onPressed: () {},
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/transaction-icon.svg',
              label: 'Transaction History',
              onPressed: () {},
            ),
            Divider(
              height: 1.h,
              color: kSecondaryColour,
              thickness: 1.0,
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/settings-icon.svg',
              label: 'Settings',
              onPressed: () {},
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/help-support-icon.svg',
              label: 'Help & Support',
              onPressed: () {},
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/about-icon.svg',
              label: 'About',
              onPressed: () {},
            ),
            SizedBox(
              height: kDefaultPadding.h,
            ),
            SideNavBarMenu(
              iconName: 'assets/svg/sign-out-icon .svg',
              label: 'Sign Out',
              onPressed: () {},
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
                          onPressed: () =>
                              Navigator.of(context).pushReplacementNamed(
                            BottomNavBar.data,
                          ),
                        ),
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/data-icon.svg',
                          label: 'Buy Data',
                          onPressed: () =>
                              Navigator.of(context).pushReplacementNamed(
                            BottomNavBar.data,
                          ),
                        ),
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/internet-icon.svg',
                          label: 'Internet',
                          onPressed: () =>
                              Navigator.of(context).pushReplacementNamed(
                            BottomNavBar.internet,
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
                          onPressed: () =>
                              Navigator.of(context).pushReplacementNamed(
                            BottomNavBar.cable,
                          ),
                        ),
                        CustomDashboardFeatureIconCard(
                          icon: 'assets/svg/electricity-icon.svg',
                          label: 'Pay Electric Bills',
                          onPressed: () =>
                              Navigator.of(context).pushReplacementNamed(
                            BottomNavBar.electricity,
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
    _selectedIndex = index;
    switch (_selectedIndex) {
      case 0:
        null;
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(BottomNavBar.internet);
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(BottomNavBar.data);
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(BottomNavBar.electricity);
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed(BottomNavBar.cable);
        break;
      default:
        return;
    }
  }
}

class SideNavBarMenu extends StatelessWidget {
  const SideNavBarMenu({
    Key? key,
    required this.iconName,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String iconName, label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconName,
        width: kDefaultIconSize.w,
        height: kDefaultIconSize.h,
      ),
      title: CustomText(
        text: label,
        textColor: kPrimaryColour,
      ),
      horizontalTitleGap: 1.w,
      onTap: onPressed,
    );
  }
}
