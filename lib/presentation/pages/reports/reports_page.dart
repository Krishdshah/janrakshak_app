import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Note: Ensure the path to AppColors and AlertCard is correct
import 'package:janrakshak/core/constants/app_colors.dart';
import 'package:janrakshak/presentation/widgets/alert_card.dart';

// NOTE: We assume AlertCard is either defined here or available via import.
// For simplicity, it is omitted here, but required to be defined externally.

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Reports', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.magnifyingGlass)),
          TextButton(onPressed: () {}, child: const Text('Filter', style: TextStyle(color: AppColors.primaryBlue))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildReportFilterChips(),
            const SizedBox(height: 20),

            // --- Reports List ---
            const Text('Live User Submissions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            _buildUserReportCard(
              reporter: 'Harpreet Singh',
              time: '2 hours ago',
              status: 'Verified',
              issue: 'Road completely submerged near Gurudwara',
              details: 'Water level is above 3 feet on GT Road. Vehicles cannot pass through.',
              affected: 23,
            ),
            const SizedBox(height: 10),

            _buildUserReportCard(
              reporter: 'Manpreet Kaur',
              time: '4 hours ago',
              status: 'Pending',
              issue: 'Water logging in residential area',
              details: 'Streets are flooded but manageable. Drainage system seems blocked.',
              affected: 56,
            ),
            const SizedBox(height: 10),

            // --- End of List Placeholder ---
            Center(
              child: TextButton(onPressed: () {}, child: const Text('Load More Community Reports')),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildReportFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip('Live', AppColors.primaryBlue),
          _buildChip('High Risk', AppColors.accentRed),
          _buildChip('Verified', AppColors.accentGreen),
          _buildChip('Pending', AppColors.primaryOrange),
          _buildChip('Evacuation', AppColors.primaryBlue),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        backgroundColor: color.withOpacity(0.1),
        shape: StadiumBorder(side: BorderSide(color: color)),
      ),
    );
  }

  Widget _buildUserReportCard({
    required String reporter,
    required String time,
    required String status,
    required String issue,
    required String details,
    required int affected,
  }) {
    Color statusColor = status == 'Verified' ? AppColors.accentGreen : AppColors.primaryOrange;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Reporter Info
                Text(reporter, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                // Status Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const Divider(height: 20),

            Text(issue, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(details, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$affected affected', style: const TextStyle(color: AppColors.accentRed, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('View Details')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}