import 'package:all4sport/Services/LocalisationState.dart';
import 'package:all4sport/Services/StateManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/BottomBar.dart';
import 'Components/PanierFab.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Consumer<AppState>(
            builder: (context, appState, child) {
              return Column(
                children: [
                  const Text("Mes informations : "),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Localisation :  "),
                  Consumer<LocationProvider>(
                    builder: (context, locationProvider, child) {
                      return Text(locationProvider.cityName);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: const PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const BottomBar(selectedTab: 2),
    );
  }
}
