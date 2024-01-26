import 'package:flutter/material.dart';

import 'Components/BottomBar.dart';
import 'Components/PanierFab.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profil'),
      ),
      floatingActionButton: PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(selectedTab: 1),
    );
  }
}
