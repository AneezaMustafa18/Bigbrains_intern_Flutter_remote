import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud_getx_firebase/services/profile_service.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF7F9FC),
        foregroundColor: const Color(0xFF101828),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 15),

              // Profile photo
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE8F1FF),
                      border: Border.all(
                        color: const Color(0xFF0174F3),
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: controller.photoUrl.value.isNotEmpty
                          ? Image.network(
                        controller.photoUrl.value,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.person,
                            size: 65,
                            color: Color(0xFF0174F3),
                          );
                        },
                      )
                          : const Icon(
                        Icons.person,
                        size: 65,
                        color: Color(0xFF0174F3),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: controller.pickProfileImage,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0174F3),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Name
              Text(
                controller.name.value.isNotEmpty
                    ? controller.name.value
                    : 'User',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF101828),
                ),
              ),

              const SizedBox(height: 6),

              // Email
              Text(
                controller.email.value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF667085),
                ),
              ),

              const SizedBox(height: 30),

              // Profile information card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _profileTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Full Name',
                      value: controller.name.value.isNotEmpty
                          ? controller.name.value
                          : 'Not added',
                    ),

                    const Divider(height: 28),

                    _profileTile(
                      icon: Icons.email_outlined,
                      title: 'Email Address',
                      value: controller.email.value,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Edit Profile button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () => _showEditDialog(context),
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0174F3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Logout button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () => _showLogoutDialog(),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(
                      color: Colors.redAccent,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF0174F3),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101828),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController nameController =
    TextEditingController(text: controller.name.value);

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),

          Obx(
                () => ElevatedButton(
              onPressed: controller.isSaving.value
                  ? null
                  : () {
                controller.saveName(nameController.text);
              },
              child: controller.isSaving.value
                  ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Logout?',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout from your account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();

              await controller.logout();

              Get.offAllNamed('/login');

              Get.snackbar(
                'Logged Out',
                'You have been logged out successfully.',
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
                borderRadius: 14,
                backgroundColor: const Color(0xFF101828),
                colorText: Colors.white,
                icon: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}