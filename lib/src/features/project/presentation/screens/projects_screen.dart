import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launchoff/src/features/project/presentation/screens/project_tile.dart';
import '../../project.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Tech',
    'Health',
    'Finance',
    'Education'
  ];

  @override
  void initState() {
    context.read<ProjectBloc>().add(FetchAllProjects());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            items: categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
                context.read<ProjectBloc>().add(FetchAllProjects());
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) => _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProjectState state) {
    if (state is ProjectLoaded) return _buildProjectList(context, state);
    if (state is ProjectError) return _buildError(context, state.message);
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildProjectList(BuildContext context, ProjectLoaded state) {
    final projects = (selectedCategory == 'All')
        ? state.projects
        : state.projects.where((p) => p.category == selectedCategory).toList();

    if (projects.isEmpty) {
      return _centeredMessage(context, messages: ['No projects available.']);
    }

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return ProjectListTile(project: project);
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return _centeredMessage(context, messages: [message]);
  }

  Widget _centeredMessage(BuildContext context,
      {required List<String> messages}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: messages.map((m) => Text(m)).toList(),
      ),
    );
  }
}
