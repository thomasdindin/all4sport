import 'package:all4sport/Objects/Rayon.dart';
import 'package:all4sport/Views/Components/ArticleView.dart';
import 'package:all4sport/Views/Components/BottomBar.dart';
import 'package:all4sport/Views/Components/PanierFab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    child: Image.asset('assets/images/logov2.png')),
              ),
              const SizedBox(height: 24),
              Consumer<AppState>(
                builder: (context, value, child) {
                  return ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Important pour éviter le scrolling dans un autre scrollable
                    shrinkWrap:
                        true, // Important pour utiliser ListView.builder dans un SingleChildScrollView
                    itemCount:
                        appState.rayons.length, // Nombre de rayons à construire
                    itemBuilder: (context, index) {
                      // Pour chaque rayon, on crée un widget
                      Rayon rayon = appState.rayons[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              rayon.nom,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Utilisez une hauteur fixe pour le conteneur enveloppant le ListView.builder
                          SizedBox(
                            height:
                                250, // Ajustez la hauteur selon le besoin de votre mise en page
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: rayon.produits.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ArticleView(
                                    article: rayon.produits[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: const PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const BottomBar(selectedTab: 0),
    );
  }
}
