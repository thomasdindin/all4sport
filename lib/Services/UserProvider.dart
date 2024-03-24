import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Objects/Entrepot.dart';
import 'package:all4sport/Objects/Rayon.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  UserProvider();

  static final UserProvider _instance = UserProvider._internal();

  // Constructeur privé
  UserProvider._internal();

  // Méthode pour obtenir l'instance unique
  static UserProvider getInstance() {
    return _instance;
  }

  String _email = "";
  String _nom = "";
  String _prenom = "";
  bool _isConnected = false;

  String get email => _email;
  String get nom => _nom;
  String get prenom => _prenom;
  bool get isConnected => _isConnected;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setNom(String nom) {
    _nom = nom;
    notifyListeners();
  }

  void setPrenom(String prenom) {
    _prenom = prenom;
    notifyListeners();
  }

  void setIsConnected(bool isConnected) {
    _isConnected = isConnected;
    notifyListeners();
  }

}
