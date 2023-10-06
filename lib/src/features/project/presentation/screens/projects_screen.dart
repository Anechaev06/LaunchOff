import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../project/project.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectBloc = BlocProvider.of<ProjectBloc>(context);
    projectBloc.add(FetchAllProjects());

    return BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) => _buildBody(state));
  }

  Widget _buildBody(ProjectState state) {
    if (state is ProjectLoaded) {
      if (state.projects.isEmpty) {
        return _buildEmptyProjects();
      } else {
        return _buildProjectList(state);
      }
    } else if (state is ProjectError) {
      return _buildError(state);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyProjects() {
    return const Center(
      child: Text('No projects available.'),
    );
  }

  ListView _buildProjectList(ProjectLoaded state) {
    return ListView.builder(
      itemCount: state.projects.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(state.projects[index].name),
        subtitle: Text(state.projects[index].description),
      ),
    );
  }

  Center _buildError(ProjectError state) {
    return Center(child: Text(state.message));
  }
}
