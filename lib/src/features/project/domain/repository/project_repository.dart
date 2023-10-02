import '../../project.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> getAllProjects();
  Future<List<ProjectEntity>> getUserProjects();
  Future<void> createProject(ProjectEntity project);
}
