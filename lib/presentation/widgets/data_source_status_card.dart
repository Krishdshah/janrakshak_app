import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';

class DataSourceStatusCard extends StatelessWidget {
  const DataSourceStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('System Health', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildStatusRow('Weather Stations', 'Online (127/130)', AppColors.accentGreen),
            _buildStatusRow('River Sensors', 'Online (89/92)', AppColors.accentGreen),
            _buildStatusRow('Satellite Data', 'Delayed (15min)', AppColors.primaryOrange),
            _buildStatusRow('Community Reports', 'Active (234 users)', AppColors.primaryBlue),
            const SizedBox(height: 8),
            Center(
              child: TextButton(onPressed: () {}, child: const Text('View Details')),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String source, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.circle, size: 8, color: color),
              const SizedBox(width: 8),
              Text(source, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(status, style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}