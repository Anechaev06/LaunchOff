import 'dart:io';
import '../../project.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> getAllProjects();
  Future<List<ProjectEntity>> getUserProjects(String userId);
  Future<void> createProject(ProjectEntity project);
  Future<List<ProjectEntity>> getProjectsByCategory(String category);
  Future<List<String>> uploadImages(List<File> images);
  Future<void> deleteProject(String projectId);
}
