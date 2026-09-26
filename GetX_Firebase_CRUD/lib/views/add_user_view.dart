import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final UserController userController = Get.find<UserController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _addUser() async {
    if (!formKey.currentState!.validate()) return;

    final bool success = await userController.addUser(
      name: nameController.text,
      email: emailController.text,
      age: ageController.text,
    );

    if (success) {
      nameController.clear();
      emailController.clear();
      ageController.clear();

      await Future.delayed(const Duration(milliseconds: 700));

      if (mounted) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Color(0xFF344054),
          ),
        ),
        title: const Text(
          'Add New User',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4F46E5),
                            Color(0xFF7C3AED),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.person_add_alt_1_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create a new profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Add user information below.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Enter the details to add a user to your database.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF667085),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _FieldLabel(
                      title: 'Full Name',
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        hint: 'Enter full name',
                        icon: Icons.person_outline_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the user name';
                        }

                        if (value.trim().length < 2) {
                          return 'Name must be at least 2 characters';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    _FieldLabel(
                      title: 'Email Address',
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        hint: 'Enter email address',
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the email';
                        }

                        if (!GetUtils.isEmail(value.trim())) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    _FieldLabel(
                      title: 'Age',
                      icon: Icons.cake_outlined,
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        hint: 'Enter age',
                        icon: Icons.cake_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the age';
                        }

                        final int? age =
                        int.tryParse(value.trim());

                        if (age == null) {
                          return 'Please enter a valid number';
                        }

                        if (age <= 0 || age > 120) {
                          return 'Please enter an age between 1 and 120';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    Obx(
                          () => SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton.icon(
                          onPressed: userController.isAdding.value
                              ? null
                              : _addUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                            const Color(0xFFB9B7F3),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          icon: userController.isAdding.value
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Icon(
                            Icons.add_rounded,
                          ),
                          label: Text(
                            userController.isAdding.value
                                ? 'Adding User...'
                                : 'Add User',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Center(
                      child: Text(
                        'Your information will be stored securely in Firestore.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF98A2B3),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String title;
  final IconData icon;

  const _FieldLabel({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: const Color(0xFF4F46E5),
        ),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF344054),
          ),
        ),
      ],
    );
  }
}