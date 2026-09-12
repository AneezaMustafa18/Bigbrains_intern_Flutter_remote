import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/project_controller.dart';
import '../models/project_model.dart';
import '../routes/app_routes.dart';

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectModel initialProject =
    Get.arguments as ProjectModel;

    final controller = Get.find<ProjectController>();

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
          'Project Details',
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Color(0xFF0B1F3A),
            ),
            onSelected: (value) {
              final project =
              getCurrentProject(
                controller,
                initialProject.id,
              );

              if (project == null) {
                return;
              }

              if (value == 'edit') {
                Get.toNamed(
                  AppRoutes.addProject,
                  arguments: project,
                );
              }

              if (value == 'delete') {
                showDeleteDialog(
                  context,
                  controller,
                  project,
                );
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF1769E0),
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text('Edit Project'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text('Delete Project'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),

      body: Obx(
            () {
          final project = getCurrentProject(
            controller,
            initialProject.id,
          );

          // Project deleted
          if (project == null) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) {
              if (Get.isOverlaysOpen) {
                return;
              }

              if (Get.currentRoute ==
                  AppRoutes.projectDetail) {
                Get.back();
              }
            });

            return const Center(
              child: Text(
                'Project no longer exists.',
                style: TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 14,
                ),
              ),
            );
          }

          final bool isMobile =
              project.category == 'Mobile App';

          final bool isCompleted =
              project.status == 'Completed';

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              30,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // Project Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isMobile
                          ? const [
                        Color(0xFF0B1F3A),
                        Color(0xFF1769E0),
                      ]
                          : const [
                        Color(0xFF33245F),
                        Color(0xFF7257C9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                    BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.08),
                        blurRadius: 18,
                        offset:
                        const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration:
                        BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.15),
                          borderRadius:
                          BorderRadius.circular(
                            17,
                          ),
                        ),
                        child: Icon(
                          isMobile
                              ? Icons
                              .phone_android_rounded
                              : Icons
                              .language_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        project.description,
                        style: const TextStyle(
                          color:
                          Color(0xFFDCEAFF),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          buildHeaderTag(
                            project.category,
                            Icons.category_outlined,
                          ),
                          buildHeaderTag(
                            project.date,
                            Icons
                                .calendar_today_outlined,
                          ),
                          buildHeaderTag(
                            project.status,
                            isCompleted
                                ? Icons
                                .check_circle_outline_rounded
                                : Icons
                                .timelapse_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                const Text(
                  'Project Information',
                  style: TextStyle(
                    color: Color(0xFF0B1F3A),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                buildInfoCard(
                  icon: Icons.code_rounded,
                  iconBackground:
                  const Color(0xFFE8F1FF),
                  iconColor:
                  const Color(0xFF1769E0),
                  title: 'Technology',
                  value: project.technology,
                ),

                buildInfoCard(
                  icon: isMobile
                      ? Icons.smartphone_rounded
                      : Icons.web_rounded,
                  iconBackground:
                  const Color(0xFFEEE7FF),
                  iconColor:
                  const Color(0xFF7257C9),
                  title: 'Category',
                  value: project.category,
                ),

                buildInfoCard(
                  icon: isCompleted
                      ? Icons
                      .check_circle_outline_rounded
                      : Icons.timelapse_rounded,
                  iconBackground: isCompleted
                      ? const Color(0xFFDDF7EA)
                      : const Color(0xFFFFF2CC),
                  iconColor: isCompleted
                      ? const Color(0xFF16804E)
                      : const Color(0xFF9A6800),
                  title: 'Status',
                  value: project.status,
                ),

                buildInfoCard(
                  icon: Icons.event_note_rounded,
                  iconBackground:
                  const Color(0xFFFFE8D6),
                  iconColor:
                  const Color(0xFFE26A00),
                  title: 'Year',
                  value: project.date,
                ),

                const SizedBox(height: 10),

                // About Project
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4FF),
                    borderRadius:
                    BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFD4E7FF),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.notes_rounded,
                            color:
                            Color(0xFF1769E0),
                            size: 22,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'About This Project',
                            style: TextStyle(
                              color:
                              Color(0xFF0B1F3A),
                              fontSize: 17,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        project.description,
                        style: const TextStyle(
                          color: Color(0xFF52627A),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Edit Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.addProject,
                        arguments: project,
                      );
                    },
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF1769E0),
                      foregroundColor:
                      Colors.white,
                      elevation: 0,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),
                    label: const Text(
                      'Edit Project',
                      style: TextStyle(
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Delete Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDeleteDialog(
                        context,
                        controller,
                        project,
                      );
                    },
                    style:
                    OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(
                        color: Color(0xFFFFCDD2),
                      ),
                      backgroundColor:
                      const Color(0xFFFFF5F5),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                    icon: const Icon(
                      Icons
                          .delete_outline_rounded,
                    ),
                    label: const Text(
                      'Delete Project',
                      style: TextStyle(
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // GitHub Button
                if (project.githubLink != null) ...[
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child:
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar(
                          'GitHub',
                          project.githubLink!,
                          snackPosition:
                          SnackPosition.BOTTOM,
                          backgroundColor:
                          const Color(
                            0xFF0B1F3A,
                          ),
                          colorText:
                          Colors.white,
                          margin:
                          const EdgeInsets.all(
                            12,
                          ),
                        );
                      },
                      style: ElevatedButton
                          .styleFrom(
                        backgroundColor:
                        const Color(
                          0xFF0B1F3A,
                        ),
                        foregroundColor:
                        Colors.white,
                        elevation: 0,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.code_rounded,
                      ),
                      label: const Text(
                        'View on GitHub',
                        style: TextStyle(
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  ProjectModel? getCurrentProject(
      ProjectController controller,
      int projectId,
      ) {
    try {
      return controller.projects.firstWhere(
            (project) => project.id == projectId,
      );
    } catch (e) {
      return null;
    }
  }

  Widget buildHeaderTag(
      String text,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius:
        BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),

          const SizedBox(width: 6),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
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
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF98A2B3),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF0B1F3A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(
      BuildContext context,
      ProjectController controller,
      ProjectModel project,
      ) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20),
        ),

        title: const Text(
          'Delete Project?',
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontWeight: FontWeight.bold,
          ),
        ),

        content: Text(
          'Are you sure you want to delete "${project.title}"?',
          style: const TextStyle(
            color: Color(0xFF667085),
            height: 1.5,
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
              controller.deleteProject(
                project.id,
              );

              Get.back();
              Get.back();

              Get.snackbar(
                'Project Deleted',
                '${project.title} has been deleted.',
                snackPosition:
                SnackPosition.BOTTOM,
                backgroundColor:
                const Color(0xFF0B1F3A),
                colorText: Colors.white,
                margin:
                const EdgeInsets.all(12),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(11),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}