import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int value;
  final Color color;

  const CustomProgressBar({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: value / 100, // Convert percentage to 0.0 to 1.0
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(color),
        minHeight: 8,
      ),
    );
  }
}