import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../project.dart';

class SlidableProjectTile extends StatelessWidget {
  final ProjectEntity project;

  const SlidableProjectTile({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<ProjectBloc>().add(DeleteProject(project.id));
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
  }
}
