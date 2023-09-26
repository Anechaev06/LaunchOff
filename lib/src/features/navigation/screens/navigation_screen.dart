import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/navigation_bloc.dart';
import '../widgets/navigation_bar_widget.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  static final List<Widget> _screens = [
    const Text('Home Screen'),
    const Text('Search Screen'),
    const Text('Chat Screen'),
    const Text('Notification Screen'),
    const Text('Profile Screen'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, int>(
        builder: (context, selectedIndex) {
          return SafeArea(
            child: Scaffold(
              body: _bodyBasedOnIndex(selectedIndex),
              bottomNavigationBar:
                  NavigationBarWidget(selectedIndex: selectedIndex),
            ),
          );
        },
      ),
    );
  }

  Widget _bodyBasedOnIndex(int index) {
    return _screens[index];
  }
}
