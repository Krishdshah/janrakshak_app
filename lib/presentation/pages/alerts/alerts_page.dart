import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Note: Ensure the path to AppColors is correct
import 'package:janrakshak/core/constants/app_colors.dart';

// --- DEPENDENCIES (Assumed external widgets, defined minimally here for structure) ---

// If you don't have these files, you must create them and put the code below in them.

class AlertCard extends StatelessWidget {
  final String riskLevel;
  final String timeAgo;
  final String title;
  final String description;
  final Color color;

  const AlertCard({super.key, required this.riskLevel, required this.timeAgo, required this.title, required this.description, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: color.withOpacity(0.5))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.circleExclamation, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(riskLevel.toUpperCase(), style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(description, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
            const Icon(FontAwesomeIcons.chevronRight, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class ZoneWaterLevelCard extends StatelessWidget {
  final String district;
  final String riskLevel;
  final String waterLevel;
  final Color color;
  final String? subArea;

  const ZoneWaterLevelCard({super.key, required this.district, required this.riskLevel, required this.waterLevel, required this.color, this.subArea});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: color.withOpacity(0.5), width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(district, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                if (subArea != null) Text(subArea!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 5),
                Text(riskLevel, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(waterLevel, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
                  child: const Text('View Details', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyHelplinesCard extends StatelessWidget {
  const EmergencyHelplinesCard({super.key});

  Widget _buildHelplineItem({required IconData icon, required String title, required String number, required String buttonLabel, required VoidCallback onTap}) {
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
            foregroundColor: Colors.white,
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
            const Text('Emergency Helplines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.accentRed)),
            const SizedBox(height: 10),
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
// --- END DEPENDENCIES ---


class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('View All', style: TextStyle(color: AppColors.primaryBlue)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Alert Timeline Filter
            _buildTimelineFilter(),
            const SizedBox(height: 15),

            // Emergency Helplines Card
            const EmergencyHelplinesCard(),
            const SizedBox(height: 20),

            // Detailed Zone Statistics
            const Text('Zone-wise Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildZoneWaterLevelList(),
            const SizedBox(height: 20),

            // Live Alerts List
            const Text('Live Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            AlertCard(
              riskLevel: 'CRITICAL',
              timeAgo: '2 hours ago',
              title: 'Flash Flood Warning - Ferozepur',
              description: 'Water level rising rapidly. Evacuation recommended for low-lying areas.',
              color: AppColors.accentRed,
            ),
            const SizedBox(height: 8),
            AlertCard(
              riskLevel: 'WARNING',
              timeAgo: '4 hours ago',
              title: 'Heavy Rainfall Alert - Jalandhar',
              description: 'Continuous heavy rainfall expected for next 6 hours. Monitor water levels.',
              color: AppColors.primaryOrange,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineFilter() {
    return Row(
      children: [
        _buildFilterButton('Live', true),
        _buildFilterButton('12h', false),
        _buildFilterButton('24h', false),
        const Spacer(),
      ],
    );
  }

  Widget _buildFilterButton(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppColors.primaryBlue.withOpacity(0.1),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primaryBlue : AppColors.textDark,
          fontWeight: FontWeight.bold,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
        ),
        onSelected: (selected) {
          // Future state update logic here
        },
      ),
    );
  }

  Widget _buildZoneWaterLevelList() {
    return Column(
      children: [
        ZoneWaterLevelCard(
          district: 'Amritsar',
          riskLevel: 'Safe',
          waterLevel: '1.8m water level',
          color: AppColors.accentGreen,
        ),
        const SizedBox(height: 8),
        ZoneWaterLevelCard(
          district: 'Jalandhar',
          riskLevel: 'Moderate',
          waterLevel: '2.4m water level',
          subArea: 'Model Town',
          color: AppColors.primaryOrange,
        ),
        const SizedBox(height: 8),
        ZoneWaterLevelCard(
          district: 'Ferozepur',
          riskLevel: 'High Risk',
          waterLevel: '3.2m water level',
          color: AppColors.accentRed,
        ),
      ],
    );
  }
}