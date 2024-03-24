import 'package:all4sport/Services/LocationProvider.dart';
import 'package:all4sport/Services/ProductsState.dart';
import 'package:all4sport/Services/UserProvider.dart';
import 'package:all4sport/Views/PanierScreen.dart';
import 'package:all4sport/Views/ProfilScreen.dart';
import 'package:all4sport/Views/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/PanierState.dart';
import 'Views/HomeScreen.dart';
import 'Views/SplashScreen.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LocationProvider.getInstance()),
          ChangeNotifierProvider(
              create: (context) => PanierState.getInstance()
          ),
          ChangeNotifierProvider(create: (context) => ProductsState.getInstance()),
          ChangeNotifierProvider(create: (context) => LocationProvider.getInstance()),
          ChangeNotifierProvider(create: (context) => UserProvider.getInstance()),
        ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Afficher un dialogue de confirmation
          final shouldClose = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirmation'),
              content:
                  const Text('Voulez-vous vraiment quitter l\'application ?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Non'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Oui'),
                ),
              ],
            ),
          );

          return shouldClose ?? false;
        },
        child: MaterialApp(
          title: 'ALL4SPORT',
          initialRoute: '/splashscreen',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          routes: {
            '/': (context) => HomeScreen(),
            '/panier': (context) => const PanierScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/recherche': (context) => SearchScreen(),
            '/splashscreen': (context) => const SplashScreen(),
          },
        ));
  }
}
