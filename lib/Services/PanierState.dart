import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Services/StateManager.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PanierState extends ChangeNotifier {
  List<Article> _panier = [];
  AppState appState = AppState.getInstance();
  List<Article> get panier => _panier;

  PanierState() {
    _loadPanierFromLocalStorage();
  }

  void addToPanier(Article product) {
    _panier.add(product);

    // On ajoute la référence du produit dans le panier :
    _addToPanierInLocalStorage(product.productReference);
    notifyListeners();
  }

  void removeFromPanier(Article product) {
    _panier.remove(product);
    // On supprime la référence du produit dans le panier :
    _deleteFromPanierInLocalStorage(product.productReference);
    notifyListeners();
  }

  // Méthode pour charger le panier depuis le stockage local
  void _loadPanierFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? panierJson = prefs.getStringList('panier');

    if (panierJson != null) {
      for (var rayon in appState.rayons) {
        for (var product in rayon.produits) {
          if (panierJson.contains(product.productReference)) {
            _panier.add(product);
          }
        }
      }

      notifyListeners();
    }
  }

  void _addToPanierInLocalStorage(String productRef) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? panierJson = prefs.getStringList('panier');
    panierJson ??= [];
    panierJson.add(productRef);
    prefs.setStringList('panier', panierJson);
  }

  void _deleteFromPanierInLocalStorage(String productRef) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? panierJson = prefs.getStringList('panier');
    panierJson?.remove(productRef);
    prefs.setStringList('panier', panierJson!);
  }
}
