// lib/data/models/user_profile_model.dart

import 'package:flutter/foundation.dart';

@immutable
class UserProfileModel {
  final String firebaseUid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String role;
  final int reportsSubmitted;

  const UserProfileModel({
    required this.firebaseUid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.role = 'user',
    this.reportsSubmitted = 0,
  });

  // --- Factory method to create model from JSON (for fetching) ---
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      firebaseUid: json['firebase_uid'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      role: json['role'] as String? ?? 'user',
      reportsSubmitted: json['reports_submitted'] as int? ?? 0,
    );
  }

  // --- Method to convert model to JSON (for inserting/updating) ---
  Map<String, dynamic> toJson() {
    return {
      'firebase_uid': firebaseUid,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'role': role,
      'reports_submitted': reportsSubmitted,
      // Note: We intentionally skip 'id', 'joined_at', 'created_at', etc.,
      // as they are handled automatically by Supabase or are read-only.
    };
  }
}