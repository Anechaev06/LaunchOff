import 'package:flutter_bloc/flutter_bloc.dart';
import '../../project.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository projectRepository;

  ProjectBloc({required this.projectRepository}) : super(ProjectInitial()) {
    on<FetchAllProjects>(_fetchAllProjects);
    on<FetchUserProjects>(_fetchUserProjects);
    on<CreateProject>(_createProject);
  }

  void _handleError(Emitter<ProjectState> emit, Object e) {
    emit(ProjectError("An error occurred"));
  }

  void _fetchAllProjects(
      FetchAllProjects event, Emitter<ProjectState> emit) async {
    try {
      final allProjects = await projectRepository.getAllProjects();
      emit(ProjectLoaded(allProjects));
    } catch (e) {
      _handleError(emit, e);
    }
  }

  void _fetchUserProjects(
      FetchUserProjects event, Emitter<ProjectState> emit) async {
    try {
      final userProjects = await projectRepository.getUserProjects();
      emit(ProjectLoaded(userProjects));
    } catch (e) {
      _handleError(emit, e);
    }
  }

  void _createProject(CreateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.createProject(event.project);
      emit(ProjectLoaded([]));
    } catch (e) {
      _handleError(emit, e);
    }
  }
}
