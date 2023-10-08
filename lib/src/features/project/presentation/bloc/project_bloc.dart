import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../project.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository projectRepository;

  ProjectBloc({required this.projectRepository}) : super(ProjectInitial()) {
    on<FetchAllProjects>(_onFetchAllProjects);
    on<FetchUserProjects>(_onFetchUserProjects);
    on<CreateProject>(_onCreateProject);
    on<FetchProjectsByCategory>(_onFetchProjectsByCategory);
    on<UploadImages>(_onUploadImages);
  }

  void _onFetchAllProjects(
      FetchAllProjects event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getAllProjects();
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(ProjectError("An error occurred while fetching all projects"));
    }
  }

  void _onFetchUserProjects(
      FetchUserProjects event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getUserProjects(event.userId);
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(ProjectError("An error occurred while fetching user projects"));
    }
  }

  void _onFetchProjectsByCategory(
      FetchProjectsByCategory event, Emitter<ProjectState> emit) async {
    try {
      final projects =
          await projectRepository.getProjectsByCategory(event.category);
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(ProjectError(
          "An error occurred while fetching projects by category"));
    }
  }

  void _onCreateProject(CreateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.createProject(event.project);
      final projects =
          await projectRepository.getUserProjects(event.project.userId);
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(ProjectError("An error occurred while creating a project"));
    }
  }

  void _onUploadImages(UploadImages event, Emitter<ProjectState> emit) async {
    try {
      final imageUrls = await projectRepository.uploadImages(event.images);
      emit(ImagesUploaded(imageUrls));
    } catch (e) {
      emit(ProjectError("An error occurred while uploading images"));
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    return await projectRepository.uploadImages(images);
  }
}
