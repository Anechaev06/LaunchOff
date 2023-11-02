import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launchoff/src/core/injection_container.dart' as di;
import '../../auth/auth.dart';
import '../../project/project.dart';
import '../navigation.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<NavigationBloc>()),
        BlocProvider(create: (context) => di.sl<ProjectBloc>()),
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
