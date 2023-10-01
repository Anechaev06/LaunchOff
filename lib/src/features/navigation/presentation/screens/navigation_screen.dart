import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../auth/auth.dart';
import '../../../home/home.dart';
import '../../bloc/navigation_bloc.dart';
import '../widgets/navigation_widget.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  List<Widget> _buildScreens(AuthState authState) {
    return [
      const HomeScreen(),
      const Text('Search Screen'),
      const Text('Chat Screen'),
      const Text('Notification Screen'),
      const AuthScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<NavigationBloc>()),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<NavigationBloc, int>(
            builder: (context, selectedIndex) {
              final screens = _buildScreens(authState);
              return Scaffold(
                body: screens[selectedIndex],
                bottomNavigationBar: NavigationWidget(
                  selectedIndex: selectedIndex,
                  onSelect: (index) {
                    context
                        .read<NavigationBloc>()
                        .add(NavigationEvent.values[index]);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
