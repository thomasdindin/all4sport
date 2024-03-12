import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ChangeNotifier {
  String _cityName = "";
  Position? _currentPosition;
  String get cityName => _cityName;
  Position? get currentPosition => _currentPosition;

  LocationProvider() {
    _determinePosition();
  }


  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifie si le service de localisation est activé
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Le service de localisation n'est pas activé, ne peut pas obtenir la position
      return Future.error('Les services de localisation sont désactivés.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Les permissions sont refusées
        return Future.error('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Les permissions sont définitivement refusées
      return Future.error('Les permissions de localisation sont définitivement refusées, nous ne pouvons pas demander les permissions.');
    }

    // Quand les permissions sont accordées, obtient la position actuelle
    _currentPosition = await Geolocator.getCurrentPosition();
    await _getCityNameFromPosition(_currentPosition!);
  }

  Future<void> _getCityNameFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0]; // Prend le premier résultat

      _cityName = place.locality!; // Récupère le nom de la ville
      notifyListeners(); // Notifie les écouteurs qu'un changement a eu lieu
    } catch (e) {
      print(e);
    }
  }
}
