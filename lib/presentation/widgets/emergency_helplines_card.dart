import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';

class EmergencyHelplinesCard extends StatelessWidget {
  const EmergencyHelplinesCard({super.key});

  // Helper method uses named arguments
  Widget _buildHelplineItem({
    required IconData icon,
    required String title,
    required String number,
    required String buttonLabel,
    required VoidCallback onTap,
  }) {
    // ... (Helper function body is correct) ...
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.accentRed),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(number, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentRed,
            foregroundColor: AppColors.textLight,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          ),
          child: Text(buttonLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.accentRed.withOpacity(0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Emergency Helplines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.accentRed)), //
            const SizedBox(height: 10),

            // FIX: Uses named arguments for the helper function
            _buildHelplineItem(
              icon: FontAwesomeIcons.phoneVolume,
              title: 'Emergency Services',
              number: 'Call 112',
              buttonLabel: 'Call Now',
              onTap: () {},
            ),
            const Divider(height: 20),
            _buildHelplineItem(
              icon: FontAwesomeIcons.hospital,
              title: 'Disaster Management',
              number: 'Punjab SOMA',
              buttonLabel: 'Call Now',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}