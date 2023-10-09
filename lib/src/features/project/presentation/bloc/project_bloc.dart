import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
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
    on<DeleteProject>(_onDeleteProject);
    on<UpdateProject>(_onUpdateProject);
  }

  void _onFetchAllProjects(
      FetchAllProjects event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getAllProjects();
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void _onFetchUserProjects(
      FetchUserProjects event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getUserProjects(event.userId);
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void _onCreateProject(CreateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.createProject(event.project);
      final projects =
          await projectRepository.getUserProjects(event.project.userId);
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void _onFetchProjectsByCategory(
      FetchProjectsByCategory event, Emitter<ProjectState> emit) async {
    try {
      final projects =
          await projectRepository.getProjectsByCategory(event.category);
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void _onDeleteProject(DeleteProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.deleteProject(event.projectId);
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final projects = await projectRepository.getUserProjects(user.uid);
        emit(ProjectLoaded(projects));
      } else {
        emit(ProjectInitial());
      }
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void _onUploadImages(UploadImages event, Emitter<ProjectState> emit) async {
    try {
      final imageUrls = await projectRepository.uploadImages(event.images);
      emit(ImagesUploaded(imageUrls));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  ProjectError _handleError(dynamic error) {
    return ProjectError('An error occurred: $error');
  }

  Future<List<String>> uploadImages(List<File> images) async {
    return await projectRepository.uploadImages(images);
  }

  void _onUpdateProject(UpdateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.updateProject(event.project);
      final projects =
          await projectRepository.getUserProjects(event.project.userId);
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(_handleError(e));
    }
  }
}
