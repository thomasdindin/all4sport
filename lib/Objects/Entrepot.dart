import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';

class Entrepot {
  late int id;
  late String adresse;
  late String ville;
  late int codePostal;
  late String lat;
  late String long;

  // Le constructeur principal qui initialise toutes les propriétés.
  Entrepot(this.id, this.adresse, this.ville, this.codePostal, this.lat, this.long);

  // Un constructeur nommé fromJSON pour créer une instance à partir d'un JSON.
  Entrepot.fromJSON(Map<String, dynamic> json) {
    id = json['id'] as int;
    adresse = json['adresse'] as String;
    ville = json['ville'] as String;
    codePostal = json['codePostal'] as int;
    lat = json['latitude'] as String;
    long = json['longitude'] as String;
  }
}
