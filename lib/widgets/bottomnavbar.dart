// lib/widgets/bottomnavbar.dart
// Note: This assumes you have home_screen.dart instead of dashboard_screen.dart now
import 'package:dev_journey/screens/home_screen.dart'; // Changed from dashboard_screen
import 'package:dev_journey/screens/external_links_screen.dart';
import 'package:dev_journey/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../screens/favourite_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Make sure the screen list matches your actual screen names
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Changed from DashboardScreen
    ExternalLinksScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Theme is applied automatically via BottomNavigationBarTheme in main.dart
    return Scaffold(
      body: Center(
        // Use IndexedStack to keep state of inactive screens
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        // child: _widgetOptions.elementAt(_selectedIndex), // Original way (rebuilds screens)
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor, selectedItemColor, unselectedItemColor handled by theme
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), // Use outlined icons for inactive
            activeIcon: Icon(Icons.home), // Use filled icons for active
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined), // Use outlined icons for inactive
            activeIcon: Icon(Icons.school), // Use filled icons for active
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), // Use outlined icons for inactive
            activeIcon: Icon(Icons.favorite), // Use filled icons for active
            label: 'Favorites',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), // Use outlined icons for inactive
            activeIcon: Icon(Icons.person), // Use filled icons for active
            label: 'Profile',
          ),


        ],
      ),
    );
  }
}