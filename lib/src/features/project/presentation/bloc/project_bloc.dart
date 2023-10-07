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

  void _handleError(Emitter<ProjectState> emit, Object e) =>
      emit(ProjectError("An error occurred"));

  Future<void> _onFetchAllProjects(
          FetchAllProjects event, Emitter<ProjectState> emit) async =>
      _handleAsyncEvent(() async {
        final projects = await projectRepository.getAllProjects();
        emit(ProjectLoaded(projects));
      }, emit);

  Future<void> _onFetchUserProjects(
          FetchUserProjects event, Emitter<ProjectState> emit) async =>
      _handleAsyncEvent(() async {
        final projects = await projectRepository.getUserProjects(event.userId);
        emit(ProjectLoaded(projects));
      }, emit);

  Future<void> _onFetchProjectsByCategory(
          FetchProjectsByCategory event, Emitter<ProjectState> emit) async =>
      _handleAsyncEvent(() async {
        final projects =
            await projectRepository.getProjectsByCategory(event.category);
        emit(ProjectLoaded(projects));
      }, emit);

  Future<void> _onCreateProject(
          CreateProject event, Emitter<ProjectState> emit) async =>
      _handleAsyncEvent(
        () async {
          await projectRepository.createProject(event.project);
          final projects =
              await projectRepository.getUserProjects(event.project.userId);
          emit(ProjectLoaded(projects));
        },
        emit,
      );

  Future<void> _onUploadImages(
          UploadImages event, Emitter<ProjectState> emit) async =>
      _handleAsyncEvent(() async {
        final imageUrls = await projectRepository.uploadImages(event.images);
        emit(ImagesUploaded(imageUrls));
      }, emit);

  Future<void> _handleAsyncEvent(
      Future<void> Function() action, Emitter<ProjectState> emit) async {
    try {
      await action();
    } catch (e) {
      _handleError(emit, e);
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    return await projectRepository.uploadImages(images);
  }
}
