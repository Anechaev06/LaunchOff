import '../../project.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<ProjectEntity> projects;
  ProjectLoaded(this.projects);
}

class ProjectError extends ProjectState {
  final String message;
  ProjectError(this.message);
}

class ImagesUploaded extends ProjectState {
  final List<String> imageUrls;
  ImagesUploaded(this.imageUrls);
}
