import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../controllers/user_controller.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  // =========================
  // SIGN UP
  // =========================

  Future<bool> signup({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please fill in all fields.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Weak Password',
        'Password must be at least 6 characters.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    isLoading.value = true;

    try {
      await _authService.signUp(
        email: email,
        password: password,
      );

      Get.snackbar(
        'Account Created',
        'Your account has been created successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );

      return true;
    } on Exception catch (e) {
      Get.snackbar(
        backgroundColor:  Color(0xFFE11D48),
        colorText: Colors.white,
        'Sign Up Failed',
        _getFirebaseError(e.toString()),
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // LOGIN
  // =========================

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please enter your email and password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    isLoading.value = true;

    try {
      await _authService.login(
        email: email,
        password: password,
      );

      // Start listening to the current account's users
      Get.find<UserController>().fetchUsers();

      Get.snackbar(
        'Welcome Back',
        'Login successful.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );

      return true;
    } on Exception catch (e) {
      Get.snackbar(
        backgroundColor: Color(0xFFE11D48),
        colorText: Colors.white,
        'Login Failed',

        _getFirebaseError(e.toString()),
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> logout() async {
    try {
      // Stop current user's Firestore listener
      Get.find<UserController>().stopListening();

      await _authService.logout();

      Get.offAllNamed('/login');

      Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 18,
        backgroundGradient: const LinearGradient(
          colors: [
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        icon: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.lightBlue.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.logout_rounded,
            color: Colors.deepPurple,
            size: 22,
          ),
        ),
        titleText: const Text(
          'Logged Out 👋',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        messageText: const Text(
          'You have been safely logged out.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        boxShadows: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      );
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        icon: const Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
        ),
      );
    }
  }

  // =========================
  // FIREBASE ERROR HANDLER
  // =========================

  String _getFirebaseError(String error) {
    if (error.contains('email-already-in-use')) {
      return 'This email is already registered.';
    }

    if (error.contains('invalid-credential')) {
      return 'Invalid email or password.';
    }

    if (error.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    }

    if (error.contains('weak-password')) {
      return 'Password is too weak.';
    }

    if (error.contains('user-not-found')) {
      return 'No account found with this email.';
    }

    if (error.contains('wrong-password')) {
      return 'Incorrect password.';
    }

    return 'Something went wrong. Please try again.';
  }
}