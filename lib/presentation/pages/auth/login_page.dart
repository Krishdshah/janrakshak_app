// lib/presentation/pages/auth/login_page.dart (Final Code with Model Integration)

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janrakshak/core/constants/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import 'package:janrakshak/data/models/user_profile_model.dart'; // NEW IMPORT

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _supabase = supa.Supabase.instance.client;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Supabase Sync Logic ---
  Future<void> _syncUserProfileToSupabase(User user) async {
    final existingProfile = await _supabase
        .from('user_profiles')
        .select('id')
        .eq('firebase_uid', user.uid)
        .limit(1)
        .maybeSingle();

    // If profile does not exist, create it using the model
    if (existingProfile == null) {
      final newUserProfile = UserProfileModel(
        firebaseUid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        role: 'user',
        reportsSubmitted: 0,
      );

      final error = await _supabase
          .from('user_profiles')
          .insert(newUserProfile.toJson())
          .select()
          .maybeSingle();

      if (error != null) {
        throw supa.PostgrestException(message: 'Failed to create Supabase profile.', code: 'SUPA_SYNC_ERROR');
      }
    }
  }

  // --- Firebase Auth Logic ---
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    User? user;

    try {
      if (_isLogin) {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        user = userCredential.user;
      } else {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        user = userCredential.user;

        // CRUCIAL: Sync on new sign up
        if (user != null) {
          await _syncUserProfileToSupabase(user);
        }
      }

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Auth Error: ${e.message}')),
      );
    } on supa.PostgrestException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Database Sync Error: ${e.message}')),
      );
      // Clean up Firebase if Supabase sync fails on sign up
      if (!_isLogin) _auth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred.')),
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      // CRUCIAL: Sync profile after successful Google Sign-In
      if (user != null) {
        await _syncUserProfileToSupabase(user);
      }

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Error: ${e.message}')),
      );
    } on supa.PostgrestException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Database Sync Error: ${e.message}')),
      );
      _auth.signOut(); // Sign out if Supabase sync fails
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred during Google sign-in.')),
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
  // -----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Logo/Title
                Text(
                  _isLogin ? 'Welcome Back!' : 'Create Account',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _isLogin ? 'Sign in to access JanRakshak' : 'Sign up to submit reports',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 40),

                _buildEmailField(),
                const SizedBox(height: 15),
                _buildPasswordField(),

                if (_isLogin) _buildForgotPasswordButton(),
                const SizedBox(height: 25),

                _buildSubmitButton(),
                const SizedBox(height: 20),

                _buildDivider(),
                const SizedBox(height: 20),

                _buildGoogleSignInButton(),
                const SizedBox(height: 20),

                _buildToggleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: _getInputDecoration(label: 'Email Address', icon: FontAwesomeIcons.solidEnvelope),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: _getInputDecoration(label: 'Password', icon: FontAwesomeIcons.lock),
      obscureText: true,
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Firebase password reset logic here
        },
        child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primaryBlue)),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _submitForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: _isLoading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: AppColors.cardBackground,
          strokeWidth: 2,
        ),
      )
          : Text(
        _isLogin ? 'Sign In' : 'Sign Up',
        style: const TextStyle(fontSize: 18, color: AppColors.cardBackground, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('OR', style: TextStyle(color: Colors.grey.shade600)),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400)),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return OutlinedButton.icon(
      onPressed: _isLoading ? null : _signInWithGoogle,
      icon: const Icon(FontAwesomeIcons.google, color: AppColors.accentRed),
      label: const Text(
        'Continue with Google',
        style: TextStyle(fontSize: 18, color: AppColors.textDark),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_isLogin ? "Don't have an account?" : "Already have an account?", style: TextStyle(color: Colors.grey.shade700)),
        TextButton(
          onPressed: () {
            setState(() {
              _isLogin = !_isLogin;
              _formKey.currentState?.reset(); // Clear form on toggle
            });
          },
          child: Text(
            _isLogin ? 'Sign Up' : 'Sign In',
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
          ),
        ),
      ],
    );
  }

  InputDecoration _getInputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Icon(icon, color: AppColors.primaryBlue, size: 20),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
    );
  }
}