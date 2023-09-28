import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launchoff/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:launchoff/src/features/home/home.dart';
import '../../bloc/navigation_bloc.dart';
import '../widgets/navigation_widget.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, int>(
        builder: (context, selectedIndex) {
          return SafeArea(
            child: Scaffold(
              body: _screens[selectedIndex],
              bottomNavigationBar:
                  NavigationWidget(selectedIndex: selectedIndex),
            ),
          );
        },
      ),
    );
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    Text('Search Screen'),
    Text('Chat Screen'),
    Text('Notification Screen'),
    SignInScreen(),
  ];
}
