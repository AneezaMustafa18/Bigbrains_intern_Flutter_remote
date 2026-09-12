class ProjectModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String technology;
  final String status;
  final String date;
  final String? githubLink;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.technology,
    required this.status,
    required this.date,
    this.githubLink,
  });
}