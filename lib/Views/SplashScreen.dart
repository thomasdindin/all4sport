import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Objects/Entrepot.dart';
import 'package:all4sport/Objects/Rayon.dart';
import 'package:all4sport/Services/LocationProvider.dart';
import 'package:all4sport/Services/PanierState.dart';
import 'package:all4sport/Services/ProductsState.dart';
import 'package:all4sport/Services/api_services.dart';
import 'package:all4sport/Views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var text = "";
  var IS_LOGGED_IN = false; //TODO: Implémenter la connexion.

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      _navigateToHome();
    });
  }

  Future<List<Article>> getArticles() async {
    var api = ApiService();
    List<dynamic> produits = await api.get('produitss');

    List<Article> articles = [];
    for (var produit in produits) {
      Article article = Article.fromJSON(produit);
      articles.add(article);
    }

    return articles;
  }

  Future<List<Rayon>> getRayons() async {
    var api = ApiService();

    // On récupère les rayons :
    List<dynamic> rayons = await api.get('raya');

    List<Rayon> res = [];
    for (var rayon in rayons) {
      Rayon ray = Rayon.fromJSON(rayon);
      res.add(ray);
    }

    return res;
  }

  Future<List<Entrepot>> getEntrepots() async {
    var api = ApiService();

    // On récupère les entrepots :
    List<dynamic> entrepots = await api.get('entrepots');

    List<Entrepot> res = [];
    for (var entrepot in entrepots) {
      Entrepot ent = Entrepot.fromJSON(entrepot);
      res.add(ent);
    }


    return res;
  }

  _navigateToHome() async {
    // Récupérer l'instance de AppState
    final PanierState panierState = PanierState.getInstance();
    final ProductsState productsState = ProductsState.getInstance();
    final LocationProvider locationProvider = LocationProvider.getInstance();
    locationProvider.determinePosition();

    setState(() {
      text = "Chargement des données...";
    });

    List<Rayon> rayons = await getRayons();

    List<Article> articles = await getArticles();

    List<Entrepot> entrepots = await getEntrepots();

    // On ajoute les articles aux rayons :
    for (var rayon in rayons) {
      for (var article in articles) {
        if (article.rayonId == rayon.id) {
          rayon.addProduit(article);
        }
      }
    }

    // On ajoute les entrepots à l'instance de ProductsState :
    productsState.entrepots = entrepots;

    // On ajoute les rayons à l'instance de AppState :
    productsState.setRayons(rayons);

    setState(() {
      text = "Redirection vers l'accueil...";
    });

    if (mounted && IS_LOGGED_IN) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centrer le contenu verticalement
          children: [
            Image.asset('assets/images/logov2.png'),
            const SizedBox(
                height:
                    24), // Ajouter un espace entre le logo et l'indicateur de progression
            const CircularProgressIndicator(),
            const SizedBox(
                height:
                    24), // Ajouter un espace entre l'indicateur de progression et le texte
            Text(text),
          ],
        ),
      ),
    );
  }
}
