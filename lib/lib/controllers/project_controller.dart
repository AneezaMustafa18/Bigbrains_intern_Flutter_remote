import 'package:day20_mvc_getx/services/project_services.dart' show ProjectService;
import 'package:get/get.dart';

import '../models/project_model.dart';


class ProjectController extends GetxController {
  final ProjectService projectService = ProjectService();

  final RxList<ProjectModel> projects = <ProjectModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    projects.assignAll(
      projectService.getProjects(),
    );
  }

  void addProject(ProjectModel project) {
    projectService.addProject(project);
    projects.assignAll(
      projectService.getProjects(),
    );
  }

  void updateProject(ProjectModel updatedProject) {
    projectService.updateProject(updatedProject);
    projects.assignAll(
      projectService.getProjects(),
    );
  }

  void deleteProject(int id) {
    projectService.deleteProject(id);
    projects.assignAll(
      projectService.getProjects(),
    );
  }

  List<ProjectModel> get mobileProjects {
    return projects
        .where(
          (project) => project.category == 'Mobile App',
    )
        .toList();
  }

  List<ProjectModel> get websiteProjects {
    return projects
        .where(
          (project) => project.category == 'Website',
    )
        .toList();
  }

  int get totalProjects {
    return projects.length;
  }

  int get completedProjects {
    return projects
        .where(
          (project) => project.status == 'Completed',
    )
        .length;
  }

  int get inProgressProjects {
    return projects
        .where(
          (project) => project.status == 'In Progress',
    )
        .length;
  }

  int get totalMobileApps {
    return mobileProjects.length;
  }

  int get totalWebsites {
    return websiteProjects.length;
  }
}