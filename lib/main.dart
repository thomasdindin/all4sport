import 'package:all4sport/Views/PanierScreen.dart';
import 'package:all4sport/Views/ProfilScreen.dart';
import 'package:all4sport/Views/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/StateManager.dart';
import 'Views/HomeScreen.dart';
import 'Views/SplashScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState.getInstance(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALL4SPORT',
      initialRoute: '/splashscreen',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        '/': (context) =>  HomeScreen(),
        '/panier': (context) => const PanierScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/recherche' : (context) =>  SearchScreen(),
        '/splashscreen': (context) => const SplashScreen(),
      },
    );
  }
}
