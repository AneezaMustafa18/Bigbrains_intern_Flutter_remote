import 'package:crud_getx_firebase/controllers/auth_controller.dart' show AuthController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!formKey.currentState!.validate()) return;

    final success = await authController.signup(
      email: emailController.text,
      password: passwordController.text,
    );

    if (success) {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    IconButton(
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: Color(0xFF344054),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Logo
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4F46E5),
                            Color(0xFF7C3AED),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5)
                                .withValues(alpha: 0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Join UserHub and start managing your users.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF667085),
                      ),
                    ),

                    const SizedBox(height: 36),

                    const Text(
                      'Email address',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF344054),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }

                        if (!GetUtils.isEmail(value.trim())) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF344054),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Obx(
                          () => TextFormField(
                        controller: passwordController,
                        obscureText:
                        authController.isPasswordHidden.value,
                        decoration: _inputDecoration(
                          hint: 'Create a password',
                          icon: Icons.lock_outline_rounded,
                        ).copyWith(
                          suffixIcon: IconButton(
                            onPressed: authController
                                .togglePasswordVisibility,
                            icon: Icon(
                              authController.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF667085),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }

                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }

                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: const [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                          color: Color(0xFF667085),
                        ),
                        SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            'Password must contain at least 6 characters.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF667085),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Obx(
                          () => SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: authController.isLoading.value
                              ? null
                              : _signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                            const Color(0xFFB9B7F3),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: authController.isLoading.value
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(
                            color: Color(0xFF667085),
                            fontSize: 14,
                          ),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Color(0xFF4F46E5),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF98A2B3),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF667085),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFFE4E7EC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF4F46E5),
          width: 1.5,
        ),
      ),
    );
  }
}