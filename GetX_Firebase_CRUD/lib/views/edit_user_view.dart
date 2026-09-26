import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({super.key});

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  final UserController userController = Get.find<UserController>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController ageController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserModel user;

  @override
  void initState() {
    super.initState();

    user = Get.arguments as UserModel;

    nameController = TextEditingController(
      text: user.name,
    );

    emailController = TextEditingController(
      text: user.email,
    );

    ageController = TextEditingController(
      text: user.age.toString(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }

  // =========================
  // UPDATE USER
  // =========================

  Future<void> updateUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final bool success = await userController.updateUser(
      userId: user.id,
      name: nameController.text,
      email: emailController.text,
      age: ageController.text,
    );

    if (success && mounted) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF111827),
          ),
        ),
        title: const Text(
          'Edit User',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
      ),

      // =========================
      // BODY
      // =========================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            28,
            24,
            40,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // HEADER
                // =========================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4F46E5),
                        Color(0xFF7C3AED),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: 0.18,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Update User',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Modify the user information below.',
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

                const SizedBox(height: 28),

                // =========================
                // NAME
                // =========================

                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF344054),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(
                    hintText: 'Enter name',
                    icon: Icons.person_outline_rounded,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter a name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // =========================
                // EMAIL
                // =========================

                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF344054),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(
                    hintText: 'Enter email',
                    icon: Icons.email_outlined,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter an email';
                    }

                    if (!GetUtils.isEmail(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // =========================
                // AGE
                // =========================

                const Text(
                  'Age',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF344054),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: _inputDecoration(
                    hintText: 'Enter age',
                    icon: Icons.cake_outlined,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter age';
                    }

                    final int? age =
                    int.tryParse(value.trim());

                    if (age == null || age <= 0) {
                      return 'Please enter a valid age';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    updateUser();
                  },
                ),

                const SizedBox(height: 32),

                // =========================
                // UPDATE BUTTON
                // =========================

                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed:
                      userController.isUpdating.value
                          ? null
                          : updateUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFF4F46E5),
                        disabledBackgroundColor:
                        const Color(0xFFB8B5F3),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),
                      child: userController
                          .isUpdating.value
                          ? const SizedBox(
                        height: 23,
                        width: 23,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                          : const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save_rounded,
                            size: 20,
                          ),
                          SizedBox(width: 9),
                          Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // INPUT DECORATION
  // =========================

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF98A2B3),
        fontSize: 14,
      ),
      prefixIcon: const Icon(
        Icons.person_outline_rounded,
        color: Color(0xFF667085),
        size: 21,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE4E7EC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF4F46E5),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE11D48),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE11D48),
          width: 1.5,
        ),
      ),
    );
  }
}