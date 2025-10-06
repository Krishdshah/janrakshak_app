// lib/main.dart (Corrected Initialization)

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:janrakshak/core/constants/app_colors.dart';
import 'package:janrakshak/presentation/pages/auth/auth_check_wrapper.dart';

// IMPORTANT: This import MUST be present and the file MUST be generated
// import 'firebase_options.dart';


Future<void> main() async {
  // 1. Core Binding (MUST be first)
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Firebase
  try {
    // You MUST uncomment the 'options' line below and ensure firebase_options.dart is generated.
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully.");
  } catch (e) {
    print("FATAL ERROR: Firebase Initialization Failed: $e");
    // The app will likely fail if this doesn't complete successfully.
  }

  // 3. Initialize Supabase (Using placeholder keys for now)
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL', // Replace locally
    anonKey: 'YOUR_SUPABASE_ANON_KEY', // Replace locally
  );

  runApp(const JalRakshakApp());
}

class JalRakshakApp extends StatelessWidget {
  const JalRakshakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JanRakshak Flood Monitor',
      theme: ThemeData(
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.cardBackground,
          foregroundColor: AppColors.textDark,
        ),
        useMaterial3: true,
      ),
      // AuthCheckWrapper handles routing to Login or Main App
      home: const AuthCheckWrapper(),
    );
  }
}