import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Objects/Rayon.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'geolocator.dart';

class AppState extends ChangeNotifier {


  bool _isOnline = false;
  Position? _position;
  String _cityName = '';
  bool get isOnline => _isOnline;
  Position? get position => _position;
  String get cityName => _cityName;


  // Les rayons:
  List<Rayon> _rayons = [];



  // Méthode pour vérifier la connexion à Internet
  void checkInternetConnectivity() {
    _isOnline = true;
    notifyListeners();
  }

  // Méthode pour accéder à la position :
  void checkLocationPermission() async {
    if (_position == null) {
      // La position n'a pas été obtenue, appelez determinePosition()
      try {
        _position = await determinePosition();
      } catch (e) {
        // Gérez les erreurs liées à la géolocalisation ici
        print("Erreur lors de la récupération de la position : $e");
      }
      notifyListeners(); // Notifiez les auditeurs du changement
    }
  }

  void getCityName() async {
    if (_cityName.isEmpty) {
      // Le nom de la ville n'a pas été obtenu, appelez getCityNameFromPosition()
      try {
        _cityName = (await getCityNameFromPosition(_position!))!;
      } catch (e) {
        // Gérez les erreurs liées à la géolocalisation ici
        print("Erreur lors de la récupération du nom de la ville : $e");
      }
      notifyListeners(); // Notifiez les auditeurs du changement
    }
  }

  // Méthode pour obtenir le nom de la ville à partir de la position géographique
  Future<String?> getCityNameFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String cityName = placemark.locality ?? '';
        return cityName;
      } else {
        return null; // Aucun résultat trouvé
      }
    } catch (e) {
      print("Erreur lors de la récupération du nom de la ville : $e");
      return null;
    }
  }


}
