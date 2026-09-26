import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            userController.fetchUsers();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // =========================
              // HEADER
              // =========================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Welcome back 👋',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF667085),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'UserHub',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =========================
                      // PROFILE BUTTON
                      // =========================
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE4E7EC),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.toNamed('/profile');
                          },
                          tooltip: 'My Profile',
                          icon: const Icon(
                            Icons.person_outline_rounded,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // =========================
                      // LOGOUT BUTTON
                      // =========================
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE4E7EC),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                backgroundColor: CupertinoColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                content: const Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(
                                    color: Color(0xFF667085),
                                  ),
                                ),
                                actions: [
                                  // Cancel
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                      const Color(0xFF4F46E5),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  // Logout
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFF4F46E5),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      authController.logout();
                                    },
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          tooltip: 'Logout',
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =========================
              // STATS CARD
              // =========================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                  child: Obx(
                        () => Container(
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
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withValues(
                              alpha: 0.25,
                            ),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(
                                alpha: 0.18,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.people_alt_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Users',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${userController.users.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // =========================
              // SECTION TITLE
              // =========================
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'All Users',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),

              // =========================
              // USERS LIST
              // =========================
              Obx(
                    () {
                  // Loading
                  if (userController.isLoading.value) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                    );
                  }

                  // Empty
                  if (userController.users.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyUsersState(),
                    );
                  }

                  // Users
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      24,
                      0,
                      24,
                      110,
                    ),
                    sliver: SliverList.builder(
                      itemCount: userController.users.length,
                      itemBuilder: (context, index) {
                        final UserModel user =
                        userController.users[index];

                        return _UserCard(user: user);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // =========================
      // ADD USER BUTTON
      // =========================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/add-user');
        },
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        elevation: 8,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add User',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// USER CARD
// =====================================================

class _UserCard extends StatelessWidget {
  final UserModel user;

  const _UserCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    final String initial = user.name.isNotEmpty
        ? user.name.trim()[0].toUpperCase()
        : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE4E7EC),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // =========================
          // AVATAR
          // =========================
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4F46E5),
                  Color(0xFF8B5CF6),
                ],
              ),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // =========================
          // USER INFORMATION
          // =========================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF667085),
                  ),
                ),

                const SizedBox(height: 8),

                // Age
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${user.age} yrs',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // =========================
          // EDIT BUTTON
          // =========================
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: IconButton(
              onPressed: () {
                Get.toNamed(
                  '/edit-user',
                  arguments: user,
                );
              },
              tooltip: 'Edit User',
              icon: const Icon(
                Icons.edit_rounded,
                size: 19,
                color: Color(0xFF4F46E5),
              ),
            ),
          ),

          const SizedBox(width: 6),

          // =========================
          // DELETE BUTTON
          // =========================
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1F2),
              borderRadius: BorderRadius.circular(11),
            ),
            child: IconButton(
              onPressed: () {
                _showDeleteDialog(
                  context,
                  userController,
                  user,
                );
              },
              tooltip: 'Delete User',
              icon: const Icon(
                Icons.delete_outline_rounded,
                size: 19,
                color: Color(0xFFE11D48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // DELETE CONFIRMATION
  // =========================

  void _showDeleteDialog(
      BuildContext context,
      UserController userController,
      UserModel user,
      ) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        titlePadding: const EdgeInsets.fromLTRB(
          24,
          24,
          24,
          8,
        ),
        contentPadding: const EdgeInsets.fromLTRB(
          24,
          8,
          24,
          10,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          16,
          4,
          16,
          16,
        ),
        title: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F2),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Color(0xFFE11D48),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Delete User?',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete ${user.name}? '
              'This action cannot be undone.',
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFF667085),
          ),
        ),
        actions: [
          // Cancel
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF667085),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Delete
          ElevatedButton(
            onPressed: () async {
              Get.back();

              await userController.deleteUser(
                user.id,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// EMPTY USERS STATE
// =====================================================

class _EmptyUsersState extends StatelessWidget {
  const _EmptyUsersState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4FF),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.people_outline_rounded,
                size: 44,
                color: Color(0xFF4F46E5),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No users yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Add your first user to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF667085),
              ),
            ),
          ],
        ),
      ),
    );
  }
}