import 'dart:io';

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

class FetchProjectsByCategory extends ProjectEvent {
  final String category;
  FetchProjectsByCategory(this.category);
}

class UploadImages extends ProjectEvent {
  final List<File> images;
  UploadImages(this.images);
}

class DeleteProject extends ProjectEvent {
  final String projectId;
  DeleteProject(this.projectId);
}

class UpdateProject extends ProjectEvent {
  final ProjectEntity project;

  UpdateProject(this.project);
}
