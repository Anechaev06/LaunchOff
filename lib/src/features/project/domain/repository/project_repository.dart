import '../../project.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> getAllProjects();
  Future<List<ProjectEntity>> getUserProjects(String userId);
  Future<void> createProject(ProjectEntity project);
}
