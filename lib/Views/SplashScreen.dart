import 'package:flutter/material.dart';
import '../Services/StateManager.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var text = "Chargement de rien du tout...";


  @override
  void initState() {
    super.initState();

    // Récupérer l'instance de AppState
    final appState = AppState.getInstance();

    appState.checkInternetConnectivity();
    appState.checkLocationPermission();
    appState.getCityName();

    _navigateToHome();

  }

  _navigateToHome() async {
    // Attendez 5 secondes
    await Future.delayed(const Duration(seconds: 5));
    // Naviguez vers HomeScreen et retirez toutes les routes précédentes
    // pour que l'utilisateur ne puisse pas retourner au SplashScreen en appuyant sur le bouton de retour
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez HomeScreen par votre écran d'accueil
      );
    }

    setState(() {
      text = "Fini de charger !";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu verticalement
          children: [
            Image.asset('assets/images/logov2.png'),
            const SizedBox(height: 24), // Ajouter un espace entre le logo et l'indicateur de progression
            const CircularProgressIndicator(),
            const SizedBox(height: 24), // Ajouter un espace entre l'indicateur de progression et le texte
            Text(text),
          ],
        ),
      ),
    );
  }
}
