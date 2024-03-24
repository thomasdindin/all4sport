import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Objects/Entrepot.dart';
import 'package:all4sport/Services/LocationProvider.dart';
import 'package:all4sport/Services/PanierState.dart';
import 'package:all4sport/Services/ProductsState.dart';
import 'package:all4sport/Services/StateManager.dart';
import 'package:all4sport/Services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatelessWidget {
  final String articleRef;
  const ArticleScreen({super.key, required this.articleRef});

  @override
  Widget build(BuildContext context) {
    final productsState = ProductsState.getInstance();

    try {
      var article = productsState.getArticleByRef(articleRef);

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(article.productName),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/" + article.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${(article.productPrice.toString())}€'),
                      const SizedBox(height: 10),
                      Text(
                        article.productDescription,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Consumer<ProductsState>(
                        builder: (context, productsState, child) {
                          return FutureBuilder<String>(
                            future: getClosestEntrepot(article.id.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                return Text(
                                    'Erreur lors de la récupération de l\'entrepôt le plus proche.');
                              } else if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }

                              return Text(
                                  snapshot.data ?? 'Aucun entrepôt trouvé');
                            },
                          );
                        },
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Consumer<PanierState>(
                            builder: (context, panierState, child) {
                              return ElevatedButton(
                                  onPressed: () {
                                    panierState.addToPanier(article);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ajouter au panier'));
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      log("Erreur lors de la récupération de l'article : $e");

      return Scaffold(
        appBar: AppBar(
          title: const Text('Article'),
        ),
        body: Center(
          child: Text('Article $articleRef not found'),
        ),
      );
    }
  }

  Future<String> getClosestEntrepot(String id) async {
    final productsState = ProductsState.getInstance();
    final LocationProvider locationProvider = LocationProvider.getInstance();

    var api = ApiService();
    var entrepots = await api.get('verifproduits/$id');

    final entrepotsContenantProduit = productsState.entrepots
        .where((entrepot) =>
            entrepots.any((element) => element["id"] == entrepot.id))
        .toList();

    Position? position = await locationProvider.currentPosition;
    if (position == null) {
      return 'Position actuelle non disponible';
    }

    Entrepot? closestEntrepot;
    double? shortestDistance;

    for (Entrepot entrepot in entrepotsContenantProduit) {
      double entrepotLat = double.tryParse(entrepot.lat) ?? 0.0;
      double entrepotLong = double.tryParse(entrepot.long) ?? 0.0;

      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        entrepotLat,
        entrepotLong,
      );

      if (shortestDistance == null || distance < shortestDistance) {
        closestEntrepot = entrepot;
        shortestDistance = distance;
      }
    }

    if (closestEntrepot == null) {
      return 'Aucun entrepôt trouvé';
    }

    return "Le produit est disponible à l'entrepôt de ${closestEntrepot.ville} en ${entrepots.where((element) => element["id"]==closestEntrepot!.id).first["quantite"]} exemplaire(s)";
  }
}
