import 'package:flutter/material.dart';
import 'package:janrakshak/core/constants/app_colors.dart';

class ZoneWaterLevelCard extends StatelessWidget {
  final String district;
  final String riskLevel;
  final String waterLevel;
  final Color color;
  final String? subArea;

  // Constructor is correct, takes all arguments as named arguments
  const ZoneWaterLevelCard({
    super.key,
    required this.district,
    required this.riskLevel,
    required this.waterLevel,
    required this.color,
    this.subArea,
  });

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
                if (subArea != null)
                  Text(subArea!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(color: AppColors.textLight, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}