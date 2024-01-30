import 'package:all4sport/Objects/Article.dart';

class Rayon {
  late int id;
  late String nom;
  List<Article> produits = [];

  // Le constructeur principal qui initialise toutes les propriétés.
  Rayon(this.id, this.nom, this.produits);

  // Un constructeur nommé fromJSON pour créer une instance à partir d'un JSON.
  Rayon.fromJSON(Map<String, dynamic> json) {
    id = json['id'] as int;
    nom = json['nom'] as String;
  }

  void addProduit(Article produit) {
    produits.add(produit);
  }
}
