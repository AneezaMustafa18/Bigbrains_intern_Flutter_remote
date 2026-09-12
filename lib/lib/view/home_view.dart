import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/project_controller.dart';
import '../controllers/user_controller.dart';
import '../models/project_model.dart';
import '../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final projectController = Get.find<ProjectController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FB),
        elevation: 0,
        scrolledUnderElevation: 0,

        title: const Text(
          'My Development Hub',
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.profile);
            },
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Color(0xFF0B1F3A),
              size: 25,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: Obx(
            () {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0B1F3A),
                        Color(0xFF1769E0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello,',
                              style: TextStyle(
                                color: Color(0xFFDCEAFF),
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              userController.user.value.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Keep building. Keep learning.',
                              style: TextStyle(
                                color: Color(0xFFDCEAFF),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.code_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                // Overview Title
                const Text(
                  'Development Overview',
                  style: TextStyle(
                    color: Color(0xFF0B1F3A),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                // Overview Cards
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  // FIXED OVERFLOW
                  childAspectRatio: 1.25,

                  children: [
                    buildStatCard(
                      title: 'Mobile Apps',
                      value: projectController
                          .totalMobileApps
                          .toString(),
                      icon: Icons.phone_android_rounded,
                      backgroundColor:
                      const Color(0xFFE8F1FF),
                      iconBackground:
                      const Color(0xFFD5E7FF),
                      iconColor:
                      const Color(0xFF1769E0),
                    ),

                    buildStatCard(
                      title: 'Websites',
                      value: projectController
                          .totalWebsites
                          .toString(),
                      icon: Icons.language_rounded,
                      backgroundColor:
                      const Color(0xFFEDEAFF),
                      iconBackground:
                      const Color(0xFFDED5FF),
                      iconColor:
                      const Color(0xFF7257C9),
                    ),

                    buildStatCard(
                      title: 'Completed',
                      value: projectController
                          .completedProjects
                          .toString(),
                      icon: Icons.check_circle_outline_rounded,
                      backgroundColor:
                      const Color(0xFFE3F7EC),
                      iconBackground:
                      const Color(0xFFCDEEDB),
                      iconColor:
                      const Color(0xFF16804E),
                    ),

                    buildStatCard(
                      title: 'In Progress',
                      value: projectController
                          .inProgressProjects
                          .toString(),
                      icon: Icons.timelapse_rounded,
                      backgroundColor:
                      const Color(0xFFFFF3D9),
                      iconBackground:
                      const Color(0xFFFFE7B0),
                      iconColor:
                      const Color(0xFFC77A00),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Explore Work
                const Text(
                  'Explore My Work',
                  style: TextStyle(
                    color: Color(0xFF0B1F3A),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: buildNavigationCard(
                        title: 'Mobile Apps',
                        subtitle:
                        'My Flutter applications',
                        icon:
                        Icons.phone_android_rounded,
                        backgroundColor:
                        const Color(0xFFE8F1FF),
                        iconBackground:
                        const Color(0xFFD5E7FF),
                        iconColor:
                        const Color(0xFF1769E0),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.mobileProjects,
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: buildNavigationCard(
                        title: 'Websites',
                        subtitle:
                        'My web projects',
                        icon:
                        Icons.language_rounded,
                        backgroundColor:
                        const Color(0xFFEDEAFF),
                        iconBackground:
                        const Color(0xFFDED5FF),
                        iconColor:
                        const Color(0xFF7257C9),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.websiteProjects,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Recent Projects
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Projects',
                      style: TextStyle(
                        color: Color(0xFF0B1F3A),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.mobileProjects,
                        );
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF1769E0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                if (projectController.projects.isEmpty)
                  buildEmptyProjectsCard()
                else
                  ...projectController.projects
                      .take(3)
                      .map(
                        (project) =>
                        buildProjectTile(project),
                  ),

                const SizedBox(height: 16),

                // Profile Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.profile);
                    },
                    style:
                    OutlinedButton.styleFrom(
                      foregroundColor:
                      const Color(0xFF1769E0),
                      side: const BorderSide(
                        color: Color(0xFFBFD7F7),
                      ),
                      backgroundColor:
                      const Color(0xFFF8FBFF),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(
                      Icons.person_outline_rounded,
                    ),
                    label: const Text(
                      'View My Developer Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color backgroundColor,
    required Color iconBackground,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: iconBackground,
        ),
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius:
                  BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),

              const Spacer(),

              Text(
                value,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF344054),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavigationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color backgroundColor,
    required Color iconBackground,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: iconBackground,
          ),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius:
                BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),

            const SizedBox(height: 13),

            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF0B1F3A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF667085),
                fontSize: 11,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 10),

            Icon(
              Icons.arrow_forward_rounded,
              color: iconColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProjectTile(
      ProjectModel project,
      ) {
    final bool isMobile =
        project.category == 'Mobile App';

    final bool completed =
        project.status == 'Completed';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.projectDetail,
            arguments: project,
          );
        },
        borderRadius:
        BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: isMobile
                      ? const Color(0xFFE8F1FF)
                      : const Color(0xFFEDEAFF),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Icon(
                  isMobile
                      ? Icons.phone_android_rounded
                      : Icons.language_rounded,
                  color: isMobile
                      ? const Color(0xFF1769E0)
                      : const Color(0xFF7257C9),
                  size: 23,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        color:
                        Color(0xFF0B1F3A),
                        fontSize: 14,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      project.description,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        color:
                        Color(0xFF667085),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: completed
                      ? const Color(
                    0xFFDDF7EA,
                  )
                      : const Color(
                    0xFFFFF2CC,
                  ),
                  borderRadius:
                  BorderRadius.circular(9),
                ),
                child: Text(
                  completed
                      ? 'Done'
                      : 'Progress',
                  style: TextStyle(
                    color: completed
                        ? const Color(
                      0xFF16804E,
                    )
                        : const Color(
                      0xFF9A6800,
                    ),
                    fontSize: 9,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 5),

              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF98A2B3),
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmptyProjectsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.folder_open_rounded,
            color: Color(0xFF98A2B3),
            size: 38,
          ),

          SizedBox(height: 10),

          Text(
            'No projects yet',
            style: TextStyle(
              color: Color(0xFF344054),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 4),

          Text(
            'Add your first project to start tracking your journey.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF98A2B3),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}