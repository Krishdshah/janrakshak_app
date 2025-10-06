import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';
// NOTE: Assuming AppColors is available via package:janrakshak/core/constants/app_colors.dart


// --- STATIC DATA SETUP for Ludhiana, Punjab ---
final List<Map<String, dynamic>> staticForecastData = [
  {'day': 'Oct 2', 'risk': 'No Significant Risk', 'water_level': '0.7', 'rainfall': '3', 'confidence': 90},
  {'day': 'Oct 3', 'risk': 'No Significant Risk', 'water_level': '0.74', 'rainfall': '5', 'confidence': 88},
  {'day': 'Oct 4', 'risk': 'No Significant Risk', 'water_level': '0.78', 'rainfall': '4', 'confidence': 92},
  {'day': 'Oct 5', 'risk': 'Low Risk', 'water_level': '0.85', 'rainfall': '10', 'confidence': 85},
  {'day': 'Oct 6', 'risk': 'No Significant Risk', 'water_level': '0.82', 'rainfall': '4', 'confidence': 91},
  {'day': 'Oct 7', 'risk': 'Low Risk', 'water_level': '1.20', 'rainfall': '15', 'confidence': 79},
  {'day': 'Oct 8', 'risk': 'No Significant Risk', 'water_level': '0.90', 'rainfall': '5', 'confidence': 87},
  {'day': 'Oct 9', 'risk': 'Low Risk', 'water_level': '1.30', 'rainfall': '12', 'confidence': 82},
  {'day': 'Oct 10', 'risk': 'No Significant Risk', 'water_level': '0.95', 'rainfall': '3', 'confidence': 93},
  {'day': 'Oct 11', 'risk': 'No Significant Risk', 'water_level': '0.80', 'rainfall': '2', 'confidence': 95},
];
// ----------------------------------------

class PredictionsPage extends StatefulWidget {
  const PredictionsPage({super.key});

  @override
  State<PredictionsPage> createState() => _PredictionsPageState();
}

class _PredictionsPageState extends State<PredictionsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flood Prediction', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.cardBackground,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLocationSelectionCard(),
                  const SizedBox(height: 20),
                  _buildRiskAssessmentHeader(),
                  const SizedBox(height: 20),
                  _buildTabBar(),
                  const SizedBox(height: 10),
                  _buildTabContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelectionCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Location Selection', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text('Select area and location to get flood predictions', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 15),

            _buildDropdownField('Select State', 'Punjab'),
            const SizedBox(height: 10),

            _buildDropdownField('Select Location', 'Ludhiana'),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(FontAwesomeIcons.chartLine, size: 16),
                label: const Text('Generate Flood Prediction'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: AppColors.cardBackground,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String initialValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(color: Colors.grey)),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: initialValue,
                items: [
                  DropdownMenuItem(value: initialValue, child: Text(initialValue)),
                ],
                onChanged: (String? newValue) {
                  // State handling logic
                },
                isExpanded: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskAssessmentHeader() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.circleExclamation, size: 18, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                const Text('Flood Risk Assessment - Ludhiana', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const Text('AI-powered flood risk prediction using JanRakshak Pre-Alert Model', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const Divider(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAssessmentItem('Risk Level', 'Low Risk', AppColors.accentGreen),
                _buildAssessmentItem('Confidence', '52.8%', AppColors.primaryOrange),
                _buildAssessmentItem('Risk Date', '2025-10-07', AppColors.textDark),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentItem(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(FontAwesomeIcons.solidCircle, size: 8, color: color),
            const SizedBox(width: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primaryBlue,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryBlue.withOpacity(0.1),
          border: Border.all(color: AppColors.primaryBlue.withOpacity(0.5)),
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Charts & Graphs'),
          Tab(text: 'Detailed Forecast'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    // FIX: Set a large enough fixed height for the TabBarView content
    return SizedBox(
      height: 950, // Increased height significantly to accommodate the whole GridView + bottom padding
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildDetailedForecast(),
          _buildChartsAndGraphs(),
          _buildDetailedForecast(),
        ],
      ),
    );
  }

  Widget _buildDetailedForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('10-Day Detailed Forecast', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2.7, // FIX: Adjusted aspect ratio (was 3/2.5) for more vertical space
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: staticForecastData.length,
          itemBuilder: (context, index) {
            final data = staticForecastData[index];
            return _buildForecastCard(data);
          },
        ),
      ],
    );
  }

  Widget _buildForecastCard(Map<String, dynamic> data) {
    Color riskColor;
    if (data['risk'].contains('Low')) {
      riskColor = AppColors.primaryOrange;
    } else if (data['risk'].contains('Significant')) {
      riskColor = AppColors.accentGreen;
    } else {
      riskColor = AppColors.accentRed;
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // FIX: Reduced overall card padding (was 12)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Day Label
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Day ${data['day'].split(' ')[1]}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
              ),
            ),
            // Risk Level
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                data['risk'],
                style: TextStyle(color: riskColor, fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 1,
              ),
            ),
            const Divider(height: 6), // FIX: Reduced divider height (was 10)

            // Data Rows (Level, Rain, Conf)
            _buildDataRow(FontAwesomeIcons.water, 'Level', '${data['water_level']}m'),
            _buildDataRow(FontAwesomeIcons.cloudRain, 'Rain', '${data['rainfall']}mm'),
            _buildDataRow(FontAwesomeIcons.circleCheck, 'Conf', '${data['confidence']}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0), // FIX: Reduced vertical padding (was 2)
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColors.primaryBlue),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsAndGraphs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChartCard(
          title: 'Rainfall Trend Analysis',
          subtitle: '10-day rainfall forecast with confidence levels',
          height: 497,
          chartContent: Center(child: Text('Line Chart (Rainfall) Placeholder', style: TextStyle(color: Colors.grey[400]))),
          footer: Center(child: Text('Rainfall (mm) vs Confidence (%)', style: TextStyle(color: Colors.grey[600], fontSize: 12))),
        ),
        const SizedBox(height: 20),

        _buildChartCard(
          title: 'Flood Risk Level Trend',
          subtitle: 'Daily Risk Zone (0-5) trend for 10 days',
          height: 180,
          chartContent: Center(child: Text('Bar Chart (Risk Level Trend) Placeholder', style: TextStyle(color: Colors.grey[400]))),
          footer: Center(child: Text('Risk Zone (0-5)', style: TextStyle(color: Colors.grey[600], fontSize: 12))),
        ),
        // Added large spacing at the bottom to push content above the bottom nav bar area
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildChartCard({
    required String title,
    required String subtitle,
    required double height,
    required Widget chartContent,
    Widget? footer,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const Divider(height: 20),
            SizedBox(height: height, child: chartContent),
            if (footer != null) Padding(padding: const EdgeInsets.only(top: 8.0), child: footer),
          ],
        ),
      ),
    );
  }
}