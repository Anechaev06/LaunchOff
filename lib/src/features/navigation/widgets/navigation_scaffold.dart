import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../search/search.dart';
import '../../auth/auth.dart';
import '../../project/project.dart';
import '../navigation.dart';

class NavigationScaffold extends StatelessWidget {
  final AuthState authState;
  final int selectedIndex;

  const NavigationScaffold({
    super.key,
    required this.authState,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    const screens = [
      ProjectsScreen(),
      SearchScreen(),
      UserProjectsScreen(),
      Text('Notification Screen'),
      AuthScreen(),
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
