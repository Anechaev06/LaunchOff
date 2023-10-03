import '../../project.dart';

abstract class ProjectEvent {}

class FetchAllProjects extends ProjectEvent {}

class FetchUserProjects extends ProjectEvent {
  final String userId;
  FetchUserProjects(this.userId);
}

class CreateProject extends ProjectEvent {
  final ProjectEntity project;
  CreateProject(this.project);
}
