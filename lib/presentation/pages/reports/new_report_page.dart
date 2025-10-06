import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';
// NOTE: Assuming AppColors is correctly defined in its external file.

class NewReportPage extends StatefulWidget {
  const NewReportPage({super.key});

  @override
  State<NewReportPage> createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {
  final _formKey = GlobalKey<FormState>();
  String? _severity;
  String _locationType = 'GPS'; // State for toggling location input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Flood Report', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.xmark, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        backgroundColor: AppColors.cardBackground,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Help Text
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Help your community by reporting flood conditions in your area',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),

              // --- 1. Report Details Fields ---
              _buildReportTitleField(),
              const SizedBox(height: 16),
              _buildDetailedDescriptionField(),
              const SizedBox(height: 16),
              _buildSeverityDropdown(),

              const SizedBox(height: 30),

              // --- 2. Location Input ---
              _buildLocationToggle(),
              const SizedBox(height: 16),
              _buildLocationInputArea(),

              const SizedBox(height: 30),

              // --- 3. Media Upload Area ---
              _buildMediaDropzone(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      // --- Floating Submit/Cancel Buttons (Fixed at bottom) ---
      bottomNavigationBar: _buildBottomButtons(context),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildReportTitleField() {
    return TextFormField(
      decoration: _getInputDecoration(
        label: 'Report Title *',
        hint: 'Brief description of the situation',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a brief title.';
        }
        return null;
      },
    );
  }

  Widget _buildDetailedDescriptionField() {
    return TextFormField(
      maxLines: 4,
      decoration: _getInputDecoration(
        label: 'Detailed Description *',
        hint: 'Provide detailed information about the flood situation, water levels, affected areas, etc.',
      ).copyWith(
        alignLabelWithHint: true, // Aligns label to the top for multi-line field
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please provide detailed information.';
        }
        return null;
      },
    );
  }

  Widget _buildSeverityDropdown() {
    return DropdownButtonFormField<String>(
      value: _severity ?? 'Medium - Noticeable flooding', // Match screenshot placeholder
      decoration: _getInputDecoration(
        label: 'Severity Level',
      ),
      items: ['Low - Minor nuisance', 'Medium - Noticeable flooding', 'High - Property damage', 'Critical - Life-threatening']
          .map((String severity) {
        return DropdownMenuItem<String>(
          value: severity,
          child: Text(severity),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _severity = newValue;
        });
      },
    );
  }

  Widget _buildLocationToggle() {
    return Row(
      children: [
        // GPS Location Button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() => _locationType = 'GPS');
            },
            icon: const Icon(FontAwesomeIcons.locationCrosshairs, size: 16),
            label: const Text('GPS Location'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _locationType == 'GPS' ? AppColors.primaryBlue : Colors.grey.shade200,
              foregroundColor: _locationType == 'GPS' ? AppColors.cardBackground : AppColors.textDark,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 1), // Minimal separation
        // Predefined Location Button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() => _locationType = 'Predefined');
            },
            icon: const Icon(FontAwesomeIcons.locationDot, size: 16),
            label: const Text('Predefined Location'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _locationType == 'Predefined' ? AppColors.primaryBlue : Colors.grey.shade200,
              foregroundColor: _locationType == 'Predefined' ? AppColors.cardBackground : AppColors.textDark,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInputArea() {
    if (_locationType == 'GPS') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            readOnly: true,
            // FIX: The InputDecoration is now correctly structured for the search field
            decoration: _getInputDecoration(label: 'Location Search').copyWith(
              hintText: 'Search for location or use current location',
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.grey, size: 18),
              ),
              labelText: null, // Clear the label text for this specific search box style
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.locationArrow, size: 14),
                label: const Text('Use Current GPS Location'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primaryBlue),
              ),
              const Row(
                children: [
                  Icon(FontAwesomeIcons.locationDot, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text('Punjab, India', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Select a location from a map or list...', style: TextStyle(color: Colors.grey)),
      );
    }
  }

  Widget _buildMediaDropzone() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        // FIX: Changed BorderStyle.dashed to BorderStyle.solid
        border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [
            const Text('Images & Videos (Optional)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Icon(FontAwesomeIcons.cloudArrowUp, size: 40, color: AppColors.primaryBlue),
            const SizedBox(height: 15),
            const Text(
              'Click to upload images/videos or drag and drop',
              style: TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Images: PNG, JPG up to 500KB each\nVideos: MP4, MOV up to 5MB each\nMaximum 5 files total',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Files will be stored securely (Supabase storage or base64)',
              style: TextStyle(fontSize: 12, color: AppColors.primaryBlue),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Submit logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Submitting Report...')),
                );
                // Simulate submission delay
                Future.delayed(const Duration(milliseconds: 500), () => Navigator.pop(context));
              }
            },
            icon: const Icon(FontAwesomeIcons.paperPlane, size: 16),
            label: const Text('Submit Report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.cardBackground,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // --- UTILITY ---
  InputDecoration _getInputDecoration({
    required String label,
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      suffixIcon: suffixIcon,
    );
  }
}