import 'package:all4sport/Services/LocationProvider.dart';
import 'package:all4sport/Services/StateManager.dart';
import 'package:all4sport/Services/UserProvider.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mes informations : ", style: Theme.of(context).textTheme.headline4!),
              const SizedBox(
                height: 10,
              ),
              Consumer<UserProvider>(builder: (context, userProvider, child) {
                if (userProvider.isConnected) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nom : ${userProvider.nom}"),
                      Text("Email : ${userProvider.email}"),
                    ],
                  );
                } else {
                  return const Text("Vous n'êtes pas connecté.");
                }
              }),
              Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Localisation : ${locationProvider.cityName}"),
                    ],
                  );
                },
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    if (userProvider.isConnected) {
                      return ElevatedButton(onPressed: (){}, child: Text("Se déconnecter"));
                    } else {
                      return ElevatedButton(onPressed: (){}, child: Text("Se connecter"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),


      floatingActionButton: const PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const BottomBar(selectedTab: 2),
    );
  }
}
