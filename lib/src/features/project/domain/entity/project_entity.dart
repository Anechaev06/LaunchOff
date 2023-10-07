class ProjectEntity {
  final String id;
  final String name;
  final String description;
  final String problem;
  final String userId;
  final List<String> images;
  final String category;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.problem,
    required this.userId,
    required this.images,
    required this.category,
  });
}
