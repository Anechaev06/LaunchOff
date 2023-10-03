import '../../project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository projectRepository;

  ProjectBloc({required this.projectRepository}) : super(ProjectInitial()) {
    on<FetchAllProjects>(_onFetchAllProjects);
    on<FetchUserProjects>(_onFetchUserProjects);
    on<CreateProject>(_onCreateProject);
  }

  void _handleError(Emitter<ProjectState> emit, Object e) {
    emit(ProjectError("An error occurred"));
  }

  void _onFetchAllProjects(
      FetchAllProjects event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getAllProjects();
      emit(ProjectLoaded(projects));
    } catch (e) {
      _handleError(emit, e);
    }
  }

  void _onFetchUserProjects(
      FetchUserProjects event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getUserProjects(event.userId);
      emit(ProjectLoaded(projects));
    } catch (e) {
      _handleError(emit, e);
    }
  }

  void _onCreateProject(CreateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.createProject(event.project);
      final projects =
          await projectRepository.getUserProjects(event.project.userId);
      emit(ProjectLoaded(projects));
    } catch (e) {
      _handleError(emit, e);
    }
  }
}
