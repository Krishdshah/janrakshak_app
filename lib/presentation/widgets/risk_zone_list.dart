import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';

class RiskZoneList extends StatelessWidget {
  const RiskZoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // FIX: Removed invalid list item syntax and citation markers
          children: [
            const Text('Zone-wise Statistics', style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            _buildZoneItem('Amritsar', 'Safe', AppColors.accentGreen),
            _buildZoneItem('Jalandhar', 'Moderate', AppColors.primaryOrange),
            _buildZoneItem('Ferozepur', 'High Risk', AppColors.accentRed),
          ],
        ),
      ),
    );
  }

  Widget _buildZoneItem(String district, String risk, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // FIX: Removed invalid list item syntax and citation markers
          Text(district),
          Row(
            children: [
              Icon(FontAwesomeIcons.solidCircle, size: 10, color: color),
              const SizedBox(width: 5),
              Text(risk, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}