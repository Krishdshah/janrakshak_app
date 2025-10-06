// lib/presentation/pages/dashboard/dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';
import 'package:janrakshak/presentation/pages/reports/new_report_page.dart';
import 'package:janrakshak/presentation/widgets/alert_card.dart';
// Note: Assuming ReportSummaryCard is defined below for simplicity

// --- Dependency Widget: ReportSummaryCard ---
class ReportSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const ReportSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 1,
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Icon(icon, color: color, size: 16),
                ],
              ),
              const SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
// ------------------------------------------


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.magnifyingGlass)),
            IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.gear)),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'My Reports'),
              Tab(text: 'Analytics'),
            ],
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primaryBlue,
          ),
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(context),
            _buildMyReportsTab(),
            const Center(child: Text('Analytics Content', style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  // --- TAB CONTENT BUILDERS ---

  Widget _buildOverviewTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1. VIBRANT HEADER AREA (Gradient, Status, Quick Actions)
          _buildCurrentStatusAndActions(context),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Key Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildReportSummarySection(),
                const SizedBox(height: 30),

                const Text('Recent Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                AlertCard(
                  riskLevel: 'CRITICAL',
                  timeAgo: '2 hours ago',
                  title: 'Road completely submerged near Gurudwara',
                  description: 'Water level is above 3 feet on GT Road. Vehicles cannot pass through.',
                  color: AppColors.accentRed,
                ),
                const SizedBox(height: 8),
                AlertCard(
                  riskLevel: 'MODERATE',
                  timeAgo: '4 hours ago',
                  title: 'Water logging in residential area',
                  description: 'Streets are flooded but manageable. Drainage system seems blocked.',
                  color: AppColors.primaryOrange,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- NEW WIDGET: Current Status and Quick Actions Block (BLUE GRADIENT) ---
  Widget _buildCurrentStatusAndActions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Greeting and Location
          _buildGreetingHeader(),
          const SizedBox(height: 25),

          // Row 2: Status & Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Metrics (Water, Rain, AI Acc)
              _buildMetricItem('2.1m', 'Water Level', color: AppColors.cardBackground),
              _buildMetricItem('15mm', 'Rainfall', color: AppColors.cardBackground),
              _buildMetricItem('94%', 'AI Accuracy', color: AppColors.cardBackground),

              // Risk Level Tag (LOW)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lowRiskColor, // Light Green background
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text('LOW', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Row 3: Quick Actions Icons (Integrated Quick Actions)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickActionButton('Report', FontAwesomeIcons.file, () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => const NewReportPage()));
              }),
              _buildQuickActionButton('Predict', FontAwesomeIcons.chartLine, () {
                // Action
              }),
              _buildQuickActionButton('Emergency', FontAwesomeIcons.phone, () {
                // Action
              }),
              _buildQuickActionButton('Community', FontAwesomeIcons.users, () {
                // Action
              }),
            ],
          ),
        ],
      ),
    );
  }

  // --- HELPER METHOD DEFINITIONS ---

  Widget _buildMetricItem(String value, String label, {Color color = AppColors.cardBackground}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: color.withOpacity(0.8))),
      ],
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.cardBackground, size: 24),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: AppColors.cardBackground, fontSize: 12)),
        ],
      ),
    );
  }

  // --- EXISTING TAB CONTENT (BELOW KEY METRICS) ---

  Widget _buildMyReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reports Submitted by Krish',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.filter, size: 16),
                label: const Text('Filter'),
              ),
            ],
          ),
          const Divider(),

          AlertCard(riskLevel: 'CRITICAL', timeAgo: '2 hours ago', title: 'Road completely submerged near Gurudwara', description: 'Status: Verified. Team assigned for clearance.', color: AppColors.accentRed),
          const SizedBox(height: 10),
          AlertCard(riskLevel: 'MODERATE', timeAgo: '4 hours ago', title: 'Water logging in residential area', description: 'Status: Pending Verification. Drainage issue reported.', color: AppColors.primaryOrange),
          const SizedBox(height: 10),
          AlertCard(riskLevel: 'LOW', timeAgo: '1 day ago', title: 'Minor drainage overflow (Resolved)', description: 'Status: Resolved. Issue fixed by local authority.', color: AppColors.accentGreen),
          const SizedBox(height: 10),
          AlertCard(riskLevel: 'MODERATE', timeAgo: '12 hours ago', title: 'Tree branch blocking drain near Sector 5', description: 'Status: Pending Assignment. Needs immediate attention.', color: AppColors.primaryOrange),
          const SizedBox(height: 10),

          Center(child: TextButton(onPressed: () {}, child: const Text('Load More Reports'))),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildGreetingHeader() {
    // Contains the profile picture, greeting, and location text
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Side: Greeting and Monitor Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning, Krish',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.cardBackground),
            ),
            const Text(
              'Punjab Flood Monitor', // Title from the screenshot
              style: TextStyle(fontSize: 14, color: AppColors.cardBackground),
            ),
          ],
        ),

        // Right Side: Current Location (Replicating the condensed look)
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Current Location',
              style: TextStyle(fontSize: 12, color: AppColors.cardBackground),
            ),
            const Text(
              'Ludhiana, Punjab',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.cardBackground),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportSummarySection() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReportSummaryCard(title: 'Total Reports', value: '12', subtitle: 'All your flood reports', icon: FontAwesomeIcons.solidFileLines, color: AppColors.primaryBlue, backgroundColor: AppColors.metricBlue),
            const SizedBox(width: 10),
            const ReportSummaryCard(title: 'Critical Reports', value: '2', subtitle: 'High priority reports', icon: FontAwesomeIcons.triangleExclamation, color: AppColors.accentRed, backgroundColor: AppColors.metricPink),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReportSummaryCard(title: 'Verified Reports', value: '8', subtitle: 'Confirmed by authorities', icon: FontAwesomeIcons.solidCircleCheck, color: AppColors.accentGreen, backgroundColor: AppColors.metricGreen),
            const SizedBox(width: 10),
            const ReportSummaryCard(title: 'Pending Reports', value: '2', subtitle: 'Awaiting verification', icon: FontAwesomeIcons.solidClock, color: AppColors.primaryOrange, backgroundColor: AppColors.metricYellow),
          ],
        ),
      ],
    );
  }
}