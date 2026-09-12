import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/project_controller.dart';
import '../models/project_model.dart';
import '../routes/app_routes.dart';

class WebsiteProjectsView extends StatelessWidget {
  const WebsiteProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Websites',
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(
            () {
          final projects = controller.websiteProjects;

          if (projects.isEmpty) {
            return const Center(
              child: Text(
                'No website projects yet.',
                style: TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 15,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return buildProjectCard(
                context,
                controller,
                project,
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.addProject);
        },
        backgroundColor: const Color(0xFF7257C9),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Project',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildProjectCard(
      BuildContext context,
      ProjectController controller,
      ProjectModel project,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.projectDetail,
            arguments: project,
          );
        },
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEE7FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.language_rounded,
                      color: Color(0xFF7257C9),
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: const TextStyle(
                            color: Color(0xFF0B1F3A),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          project.date,
                          style: const TextStyle(
                            color: Color(0xFF98A2B3),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  buildStatusBadge(project.status),

                  const SizedBox(width: 4),

                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Color(0xFF667085),
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        Get.toNamed(
                          AppRoutes.addProject,
                          arguments: project,
                        );
                      } else if (value == 'delete') {
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
                                color: Color(0xFF7257C9),
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

              const SizedBox(height: 18),

              Text(
                project.description,
                style: const TextStyle(
                  color: Color(0xFF52627A),
                  fontSize: 13,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EEFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      project.technology,
                      style: const TextStyle(
                        color: Color(0xFF7257C9),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF98A2B3),
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatusBadge(String status) {
    final bool completed = status == 'Completed';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: completed
            ? const Color(0xFFDDF7EA)
            : const Color(0xFFFFF2CC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: completed
              ? const Color(0xFF16804E)
              : const Color(0xFF9A6800),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
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
          borderRadius: BorderRadius.circular(20),
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
              controller.deleteProject(project.id);

              Get.back();

              Get.snackbar(
                'Project Deleted',
                '${project.title} has been deleted.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF0B1F3A),
                colorText: Colors.white,
                margin: const EdgeInsets.all(12),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}