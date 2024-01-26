import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test si les services de localisation sont activés.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Les services de localisation sont désactivés.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Les permissions de localisation sont refusées.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Les permissions sont définitivement refusées, nous ne pouvons pas demander les permissions.
    return Future.error(
        'Les permissions de localisation sont définitivement refusées, nous ne pouvons pas demander les permissions.');
  }

  // Quand nous arrivons ici, les permissions sont accordées et nous pouvons récupérer la position de l'utilisateur.
  return await Geolocator.getCurrentPosition();
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
