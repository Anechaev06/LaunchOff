import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../project/project.dart';
import '../../../core/core.dart';
import '../../auth/auth.dart';
import '../navigation.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<NavigationBloc>()),
        BlocProvider(create: (context) => sl<ProjectBloc>()),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<NavigationBloc, int>(
            builder: (context, selectedIndex) => NavigationScaffold(
                authState: authState, selectedIndex: selectedIndex),
          );
        },
      ),
    );
  }
}
