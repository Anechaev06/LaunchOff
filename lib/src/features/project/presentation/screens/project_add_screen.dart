import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../project.dart';

class ProjectAddScreen extends StatelessWidget {
  const ProjectAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProjectBloc>(),
      child: const ProjectAddForm(),
    );
  }
}
