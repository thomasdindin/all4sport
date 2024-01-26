import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int selectedTab;
  const BottomBar({super.key,required this.selectedTab});



  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.deepOrange,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            isSelected: selectedTab == 0,
            tooltip: 'Accueil',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            isSelected: selectedTab == 1,
            tooltip: 'Profil',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}