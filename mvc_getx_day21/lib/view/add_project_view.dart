import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/project_controller.dart';
import '../models/project_model.dart';

class AddProjectView extends StatefulWidget {
  const AddProjectView({super.key});

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  final ProjectController controller =
  Get.find<ProjectController>();

  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  final TextEditingController technologyController =
  TextEditingController();

  final TextEditingController dateController =
  TextEditingController();

  final TextEditingController githubController =
  TextEditingController();

  String selectedCategory = 'Mobile App';
  String selectedStatus = 'In Progress';

  ProjectModel? editingProject;

  bool get isEditing => editingProject != null;

  @override
  void initState() {
    super.initState();

    final arguments = Get.arguments;

    if (arguments is ProjectModel) {
      editingProject = arguments;

      titleController.text = arguments.title;
      descriptionController.text = arguments.description;
      technologyController.text = arguments.technology;
      dateController.text = arguments.date;
      githubController.text = arguments.githubLink ?? '';

      selectedCategory = arguments.category;
      selectedStatus = arguments.status;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    technologyController.dispose();
    dateController.dispose();
    githubController.dispose();

    super.dispose();
  }

  void saveProject() {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        technologyController.text.trim().isEmpty ||
        dateController.text.trim().isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please fill all required fields.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0B1F3A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );

      return;
    }

    if (isEditing) {
      final ProjectModel updatedProject = ProjectModel(
        id: editingProject!.id,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        category: selectedCategory,
        technology: technologyController.text.trim(),
        status: selectedStatus,
        date: dateController.text.trim(),
        githubLink: githubController.text.trim().isEmpty
            ? null
            : githubController.text.trim(),
      );

      controller.updateProject(updatedProject);

      Get.back();

      Get.snackbar(
        'Project Updated',
        '${updatedProject.title} has been updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0B1F3A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
    } else {
      int newId = 1;

      if (controller.projects.isNotEmpty) {
        newId = controller.projects
            .map((project) => project.id)
            .reduce((a, b) => a > b ? a : b) +
            1;
      }

      final ProjectModel newProject = ProjectModel(
        id: newId,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        category: selectedCategory,
        technology: technologyController.text.trim(),
        status: selectedStatus,
        date: dateController.text.trim(),
        githubLink: githubController.text.trim().isEmpty
            ? null
            : githubController.text.trim(),
      );

      controller.addProject(newProject);

      Get.back();

      Get.snackbar(
        'Project Added',
        '${newProject.title} has been added successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0B1F3A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isWebsite = selectedCategory == 'Website';

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

        title: Text(
          isEditing ? 'Edit Project' : 'Add Project',
          style: const TextStyle(
            color: Color(0xFF0B1F3A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isWebsite
                      ? const [
                    Color(0xFF33245F),
                    Color(0xFF7257C9),
                  ]
                      : const [
                    Color(0xFF0B1F3A),
                    Color(0xFF1769E0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      isWebsite
                          ? Icons.language_rounded
                          : Icons.phone_android_rounded,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEditing
                              ? 'Update Your Project'
                              : 'Add New Project',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          isEditing
                              ? 'Update your project information.'
                              : 'Keep your development journey organized.',
                          style: const TextStyle(
                            color: Color(0xFFDCEAFF),
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
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

            buildTextField(
              controller: titleController,
              label: 'Project Title',
              hint: 'e.g. PasteIt',
              icon: Icons.title_rounded,
            ),

            const SizedBox(height: 14),

            buildTextField(
              controller: descriptionController,
              label: 'Description',
              hint: 'Briefly describe your project',
              icon: Icons.description_outlined,
              maxLines: 3,
            ),

            const SizedBox(height: 14),

            buildTextField(
              controller: technologyController,
              label: 'Technology',
              hint: 'e.g. Flutter + Firebase',
              icon: Icons.code_rounded,
            ),

            const SizedBox(height: 14),

            buildTextField(
              controller: dateController,
              label: 'Year',
              hint: 'e.g. 2026',
              icon: Icons.calendar_today_outlined,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 14),

            // Category
            buildDropdown(
              label: 'Category',
              icon: Icons.category_outlined,
              value: selectedCategory,
              items: const [
                'Mobile App',
                'Website',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
            ),

            const SizedBox(height: 14),

            // Status
            buildDropdown(
              label: 'Status',
              icon: Icons.timelapse_rounded,
              value: selectedStatus,
              items: const [
                'In Progress',
                'Completed',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedStatus = value;
                  });
                }
              },
            ),

            const SizedBox(height: 14),

            buildTextField(
              controller: githubController,
              label: 'GitHub Link (Optional)',
              hint: 'Paste your GitHub repository link',
              icon: Icons.link_rounded,
              keyboardType: TextInputType.url,
            ),

            const SizedBox(height: 28),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: saveProject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isWebsite
                      ? const Color(0xFF7257C9)
                      : const Color(0xFF1769E0),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: Icon(
                  isEditing
                      ? Icons.save_outlined
                      : Icons.add_rounded,
                ),
                label: Text(
                  isEditing
                      ? 'Save Changes'
                      : 'Add Project',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Cancel Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF667085),
                  side: const BorderSide(
                    color: Color(0xFFDCE3EC),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF344054),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF98A2B3),
              fontSize: 13,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 4,
                right: 4,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1769E0),
                size: 21,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 50,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFF1769E0),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF344054),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 7),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF667085),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF1769E0),
                size: 21,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            items: items.map(
                  (item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Color(0xFF344054),
                      fontSize: 13,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}