import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../project.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String selectedCategory = 'All';

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
          CategoryPopupMenu(
            selectedCategory: selectedCategory,
            onCategorySelected: (String newValue) {
              setState(() {
                selectedCategory = newValue;
                context.read<ProjectBloc>().add(FetchAllProjects());
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) =>
            ProjectList(state: state, selectedCategory: selectedCategory),
      ),
    );
  }
}
