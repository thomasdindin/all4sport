import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Objects/Rayon.dart';
import 'package:all4sport/Services/api_services.dart';
import 'package:flutter/material.dart';
import '../Services/StateManager.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var text = "";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // Récupérer l'instance de AppState
      final appState = AppState.getInstance();

      // Vérifier la connectivité internet et la permission de localisation
      appState.checkInternetConnectivity();
      appState.checkLocationPermission();

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

  _navigateToHome() async {
    // Récupérer l'instance de AppState
    final appState = AppState.getInstance();

    setState(() {
      text = "Chargement des données...";
    });

    //TODO: Décommenter quand Drodz aura daigné déposer l'api
    // List<Rayon> rayons = await getRayons();

    List<Rayon> rayons = [
      Rayon(1, "Rayon 1", []),
      Rayon(2, "Rayon 2", []),
      Rayon(3, "Rayon 3", []),
      Rayon(4, "Rayon 4", []),
      Rayon(5, "Rayon 5", []),
    ];

    //TODO: Décommenter quand Drodz aura daigné déposer l'api
    //List<Article> articles = await getArticles();

    List<Article> articles = [];

    for (int i = 0; i < 100; i++) {
      Article article =
          Article("Article $i", "Description $i", i * 100, "$i", i % 5 + 1);
      articles.add(article);
    }

    // On ajoute les articles aux rayons :
    for (var rayon in rayons) {
      for (var article in articles) {
        if (article.rayonId == rayon.id) {
          rayon.addProduit(article);
          log("Ajout de l'article ${article.productName} au rayon ${rayon.nom}, ref : ${article.productReference}");
        }
      }
    }

    // On ajoute les rayons à l'instance de AppState :
    appState.setRayons(rayons);

    setState(() {
      text = "Redirection vers l'accueil...";
    });

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeScreen()), // Remplacez HomeScreen par votre écran d'accueil
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
