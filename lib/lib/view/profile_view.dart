import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/user_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FB),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF0B1F3A),
          ),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0B1F3A),
                    Color(0xFF1769E0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Image
                  Obx(
                        () => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.35),
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: controller.profileImageBytes.value != null
                                ? Image.memory(
                              controller.profileImageBytes.value!,
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            )
                                : const Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        ),

                        // Camera Button
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: GestureDetector(
                            onTap: () {
                              pickProfileImage(controller);
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1769E0),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Change Photo
                  GestureDetector(
                    onTap: () {
                      pickProfileImage(controller);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Change Photo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Reactive User Information
                  Obx(
                        () => Column(
                      children: [
                        Text(
                          controller.user.value.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 7),

                        Text(
                          controller.user.value.email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFDCEAFF),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Flutter Developer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Update Name Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFD4E7FF),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E7FF),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Color(0xFF1769E0),
                    ),
                  ),

                  const SizedBox(width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update Your Name',
                          style: TextStyle(
                            color: Color(0xFF0B1F3A),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Change your name and see the UI update instantly.',
                          style: TextStyle(
                            color: Color(0xFF667085),
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      showUpdateNameDialog(
                        context,
                        controller,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF1769E0),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Skills
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Skills',
                style: TextStyle(
                  color: Color(0xFF0B1F3A),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildSkill('Flutter'),
                buildSkill('Dart'),
                buildSkill('Firebase'),
                buildSkill('GetX'),
                buildSkill('Provider'),
                buildSkill('HTML'),
                buildSkill('CSS'),
                buildSkill('Bootstrap'),
                buildSkill('PHP'),
                buildSkill('MySQL'),
              ],
            ),

            const SizedBox(height: 28),

            // Development Journey
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEAFF),
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                  color: const Color(0xFFDED5FF),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timeline_rounded,
                        color: Color(0xFF7257C9),
                        size: 23,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'My Development Journey',
                        style: TextStyle(
                          color: Color(0xFF33245F),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14),

                  Text(
                    'I am continuously learning and building projects '
                        'to improve my Flutter and software development skills.',
                    style: TextStyle(
                      color: Color(0xFF5F5678),
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // App Purpose
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3D9),
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                  color: const Color(0xFFFFE3A8),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: Color(0xFFC77A00),
                    size: 23,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This app is my personal development workspace '
                          'where I can keep track of my projects, progress '
                          'and learning journey.',
                      style: TextStyle(
                        color: Color(0xFF73561F),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickProfileImage(
      UserController controller,
      ) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      return;
    }

    final Uint8List imageBytes = await image.readAsBytes();

    controller.updateProfileImage(imageBytes);

    Get.snackbar(
      'Profile Updated',
      'Your profile photo has been updated.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0B1F3A),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }

  Widget buildSkill(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFDCE3EC),
        ),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Color(0xFF344054),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void showUpdateNameDialog(
      BuildContext context,
      UserController controller,
      ) {
    final TextEditingController nameController =
    TextEditingController(
      text: controller.user.value.name,
    );

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Update Name',
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter your name',
            filled: true,
            fillColor: const Color(0xFFF4F7FB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF667085),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              controller.updateName(
                nameController.text,
              );

              Get.back();

              Get.snackbar(
                'Name Updated',
                'Your name has been updated successfully.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF0B1F3A),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1769E0),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text(
              'Update',
            ),
          ),
        ],
      ),
    );
  }
}