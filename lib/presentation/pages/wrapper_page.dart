// lib/presentation/pages/wrapper_page.dart (Full Code)

import 'package:flutter/material.dart';
import 'package:janrakshak/presentation/pages/dashboard/dashboard_page.dart';
import 'package:janrakshak/presentation/pages/alerts/alerts_page.dart';
import 'package:janrakshak/presentation/pages/predictions/predictions_page.dart';
import 'package:janrakshak/presentation/pages/reports/reports_page.dart';
import 'package:janrakshak/presentation/pages/profile/profile_page.dart';
import 'package:janrakshak/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Ensure Font Awesome is available

// NOTE: Since the local placeholders for Alerts, Reports, and Profile were removed,
// the app now correctly loads the detailed, implemented pages from their external files.

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),  // Index 0
    const AlertsPage(),     // Index 1
    const PredictionsPage(),// Index 2
    const ReportsPage(),    // Index 3
    const ProfilePage(),    // Index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}