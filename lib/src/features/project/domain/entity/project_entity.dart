class ProjectEntity {
  final String id;
  final String name;
  final String description;
  final String userId;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    this.userId = '',
  });
}
