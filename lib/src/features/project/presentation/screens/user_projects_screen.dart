// Filename: user_projects_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../project.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<ProjectBloc>().add(FetchUserProjects(user.uid));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Your Projects")),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoaded) {
            return ListView.builder(
              itemCount: state.projects.length,
              itemBuilder: (context, index) {
                final project = state.projects[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          context
                              .read<ProjectBloc>()
                              .add(DeleteProject(project.id));
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                  child: ProjectTile(project: project),
                );
              },
            );
          }
          return ProjectList(state: state, isAuthenticated: user != null);
        },
      ),
      floatingActionButton: user == null
          ? null
          : FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProjectAddScreen()),
              ),
              child: const Icon(Icons.add),
            ),
    );
  }
}
