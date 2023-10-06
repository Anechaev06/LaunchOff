import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/auth.dart';
import '../../project/project.dart';
import '../navigation.dart';

class NavigationScaffold extends StatelessWidget {
  final AuthState authState;
  final int selectedIndex;

  const NavigationScaffold(
      {super.key, required this.authState, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final screens = [
      const ProjectsScreen(),
      const Text('Search Screen'),
      const UserProjectsScreen(),
      const Text('Notification Screen'),
      const AuthScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: NavigationBarWidget(
          selectedIndex: selectedIndex,
          onSelect: (index) =>
              context.read<NavigationBloc>().add(NavigationEvent.values[index]),
        ),
      ),
    );
  }
}
