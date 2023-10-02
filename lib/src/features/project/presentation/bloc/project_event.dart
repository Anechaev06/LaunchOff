import '../../project.dart';

abstract class ProjectEvent {}

class FetchAllProjects extends ProjectEvent {}

class FetchUserProjects extends ProjectEvent {}

class CreateProject extends ProjectEvent {
  final ProjectEntity project;
  CreateProject(this.project);
}
