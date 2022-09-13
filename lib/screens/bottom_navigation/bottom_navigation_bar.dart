import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../cable/cable_screen.dart';
import '../components/custom_bottom_navigation_icon.dart';
import '../dashboard/dashboard_screen.dart';
import '../data/data_screen.dart';
import '../electricity/electricity_screen.dart';
import '../internet/internet_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.screenIndex}) : super(key: key);

  static const String internet = 'internet navigation';
  static const String data = 'data navigation';
  static const String electricity = 'electricity navigation';
  static const String cable = 'cable navigation';
  final int screenIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Container(),
    const InternetScreen(),
    const DataScreen(),
    const ElectricityScreen(),
    const CableScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.screenIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22.0),
          topRight: Radius.circular(22.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: kPrimaryColour,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kSecondaryColour,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/home-icon.svg',
                iconColour:
                    _selectedIndex == 0 ? kSecondaryColour : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Internet',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/internet-icon.svg',
                iconColour:
                    _selectedIndex == 1 ? kSecondaryColour : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Data',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/data-icon.svg',
                iconColour:
                    _selectedIndex == 2 ? kSecondaryColour : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Electricity',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/electricity-icon.svg',
                iconColour:
                    _selectedIndex == 3 ? kSecondaryColour : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Cable Tv',
              icon: CustomBottomNavigationIcon(
                iconName: 'assets/svg/cable-icon.svg',
                iconColour:
                    _selectedIndex == 4 ? kSecondaryColour : Colors.grey,
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (selectedIndex) => _onItemTapped(selectedIndex),
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  _onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacementNamed(DashboardScreen.id);
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }
}


