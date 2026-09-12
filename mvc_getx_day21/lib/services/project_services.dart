import '../models/project_model.dart';

class ProjectService {
  // In-memory project storage
  final List<ProjectModel> _projects = [];

  // Get all projects
  List<ProjectModel> getProjects() {
    return _projects;
  }

  // Add project
  void addProject(ProjectModel project) {
    _projects.add(project);
  }

  // Update project
  void updateProject(ProjectModel updatedProject) {
    final index = _projects.indexWhere(
          (project) => project.id == updatedProject.id,
    );

    if (index != -1) {
      _projects[index] = updatedProject;
    }
  }

  // Delete project
  void deleteProject(int id) {
    _projects.removeWhere(
          (project) => project.id == id,
    );
  }
}