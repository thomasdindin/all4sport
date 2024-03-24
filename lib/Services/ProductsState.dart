import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Objects/Entrepot.dart';
import 'package:all4sport/Objects/Rayon.dart';
import 'package:flutter/material.dart';

class ProductsState extends ChangeNotifier {

  ProductsState();

  static final ProductsState _instance = ProductsState._internal();

  // Constructeur privé
  ProductsState._internal();

  // Méthode pour obtenir l'instance unique
  static ProductsState getInstance() {
    return _instance;
  }

  // Les rayons:
  List<Rayon> _rayons = [];
  List<Rayon> get rayons => _rayons;
  List<Entrepot> entrepots = [];


  // Méthode pour obtenir les rayons :
  void setRayons(List<Rayon> rayons) {
    _rayons = rayons;
    notifyListeners();
  }

  List<Rayon> getRayons() {
    return _rayons;
  }

  Article getArticleByRef(String ref) {
    for (var rayon in _rayons) {
      for (var article in rayon.produits) {
        if (article.productReference == ref) {
          return article;
        }
      }
    }

    log("Article non trouvé pour la référence $ref");
    throw Exception('Article non trouvé');
  }

}
