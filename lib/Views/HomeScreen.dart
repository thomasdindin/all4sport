import 'package:all4sport/Views/Components/BottomBar.dart';
import 'package:all4sport/Views/Components/PanierFab.dart';
import 'package:flutter/material.dart';

import '../Services/StateManager.dart';

class HomeScreen extends StatelessWidget {

  final AppState appState = AppState.getInstance();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                    child: Image.asset('assets/images/logov2.png')
                ),
              ),
              const SizedBox(height: 24),
              Text(

                appState.cityName,
              )
            ],
          ),
        ),
      ),

      floatingActionButton: const PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomBar(selectedTab: 0),
    );
  }
}
