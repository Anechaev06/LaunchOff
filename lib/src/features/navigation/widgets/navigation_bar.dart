import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const NavigationBarWidget(
      {super.key, required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onSelect,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rocket_launch_outlined),
          activeIcon: Icon(Icons.rocket_launch_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          activeIcon: Icon(Icons.notifications_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: '',
        ),
      ],
    );
  }
}
