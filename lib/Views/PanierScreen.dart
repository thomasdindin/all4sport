import 'package:all4sport/Views/Components/BottomBar.dart';
import 'package:all4sport/Views/Components/PanierFab.dart';
import 'package:flutter/material.dart';

class PanierScreen extends StatelessWidget {
  const PanierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Panier'),
        ),
      ),
      floatingActionButton: PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomBar(selectedTab: 3),
    );
  }
}
