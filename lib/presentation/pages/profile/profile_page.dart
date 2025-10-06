import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Note: Ensure the path to AppColors is correct
import 'package:janrakshak/core/constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showSettingsModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // --- 1. Profile Header (Inspired by the mental health app) ---
            _buildProfileHeader(context),
            const SizedBox(height: 30),

            // --- 2. Quick Access Metrics/Settings (Custom Cards) ---
            _buildRecentResults(),
            const SizedBox(height: 30),

            // --- 3. Placeholder for other profile actions ---
            const Text('Account Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildActionCard('Submit Feedback', FontAwesomeIcons.comment),
            _buildActionCard('Log Out', FontAwesomeIcons.signOut),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    // Placeholder for user's profile picture and name
    return Column(
      children: [
        // Profile Image Circle
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryBlue.withOpacity(0.2), // Soft background color
          ),
          child: const Center(
            child: Icon(FontAwesomeIcons.userCircle, size: 80, color: AppColors.primaryBlue),
          ),
        ),
        const SizedBox(height: 15),

        // User Name & Email (Using Krish's details)
        const Text('Krish D Shah', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text('thekrishdshahbhs@gmail.com', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 15),

        // Edit Details Button
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryBlue),
          ),
          child: const Text('Edit Details'),
        ),
      ],
    );
  }

  Widget _buildRecentResults() {
    // Inspired by the "Mental Score" and "Mind Anchor" curved cards
    // Using custom colors defined in the AppColors context
    const Color scoreColor = Color(0xFF6D4C41);
    const Color profileColor = Color(0xFF6A1B9A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Flood Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              // Flood Score
              child: _buildMetricCard('Flood Score', '70', scoreColor, AppColors.metricGreen),
            ),
            const SizedBox(width: 15),
            Expanded(
              // Risk Profile
              child: _buildMetricCard('Risk Profile', 'LOW', profileColor, AppColors.metricBlue),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 140,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
          Center(
            child: Text(value, style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(title),
        trailing: const Icon(FontAwesomeIcons.chevronRight, size: 14, color: Colors.grey),
        onTap: () {
          // Handle navigation/action
        },
      ),
    );
  }

  void _showSettingsModal(BuildContext context) {
    // Settings menu inspired by the bottom sheet in the screenshot
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Menu Items
              _buildModalOption('Settings', () {}),
              _buildModalOption('Change Password', () {}),
              _buildModalOption('Emergency Contact', () {}),
              _buildModalOption('Feedback', () {}),
              _buildModalDeleteOption('Delete Account', () {}),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalOption(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  Widget _buildModalDeleteOption(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.accentRed)),
      onTap: onTap,
    );
  }
}