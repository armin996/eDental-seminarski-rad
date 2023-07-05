import 'package:edental/screens/settings/screens/settings_screen.dart';
import 'package:edental/screens/appointments/appointment_screen.dart';
import 'package:edental/screens/treatment/treatments_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  List<Widget> tabItems = [
    const AppointmentScreen(),
    const TreatmentScreen(),
    const AccountScreen()
  ];

  void onNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabItems[_selectedIndex],
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
              backgroundColor: Colors.cyan,
              label: 'Home',
              icon: Icon(Icons.home)),
          const BottomNavigationBarItem(
              label: 'Schedule', icon: Icon(Icons.schedule)),
          const BottomNavigationBarItem(
              label: 'Settings', icon: Icon(Icons.settings)),
        ],
        currentIndex: _selectedIndex,
        onTap: onNavItemSelected,
      ),
    );
  }
}
