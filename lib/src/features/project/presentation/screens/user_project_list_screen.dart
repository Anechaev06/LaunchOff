import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../project/project.dart';

class UserProjectListScreen extends StatelessWidget {
  const UserProjectListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final projectBloc = BlocProvider.of<ProjectBloc>(context);
    projectBloc.add(FetchUserProjects());

    return Scaffold(
      appBar: AppBar(title: const Text("Your Projects")),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) => _buildBody(state),
      ),
    );
  }

  Widget _buildBody(ProjectState state) {
    if (state is ProjectLoaded) {
      return _buildProjectList(state);
    } else if (state is ProjectError) {
      return _buildError(state);
    }
    return const CircularProgressIndicator();
  }

  ListView _buildProjectList(ProjectLoaded state) {
    if (state.projects.isEmpty) {
      return ListView(
        children: const [ListTile(title: Text("No projects available"))],
      );
    }
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
