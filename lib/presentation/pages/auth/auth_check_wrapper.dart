// lib/presentation/pages/auth/auth_check_wrapper.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:janrakshak/presentation/pages/auth/login_page.dart';
import 'package:janrakshak/presentation/pages/wrapper_page.dart';

class AuthCheckWrapper extends StatelessWidget {
  const AuthCheckWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder listens to changes in the Firebase Authentication state
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading screen
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user != null) {
          // User is signed in. Go to main app navigation.
          return const WrapperPage();
        } else {
          // User is NOT signed in. Go to the Login Page.
          return const LoginPage();
        }
      },
    );
  }
}S