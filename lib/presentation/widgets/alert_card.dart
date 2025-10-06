import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';

class AlertCard extends StatelessWidget {
  final String riskLevel;
  final String timeAgo;
  final String title;
  final String description;
  final Color color;

  const AlertCard({
    super.key,
    required this.riskLevel,
    required this.timeAgo,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      // Use the alert color to draw attention
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color.withOpacity(0.5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon for Alert Level
            Icon(FontAwesomeIcons.circleExclamation, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Risk Level (CRITICAL, WARNING, LOW)
                      Text(
                          riskLevel,
                          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                      // Time Ago
                      Text(
                          timeAgo,
                          style: const TextStyle(color: Colors.grey, fontSize: 12)
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Alert Title
                  Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 4),
                  // Alert Description
                  Text(
                      description,
                      style: const TextStyle(fontSize: 13)
                  ),
                ],
              ),
            ),
            // Navigation Arrow
            const Icon(FontAwesomeIcons.chevronRight, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}