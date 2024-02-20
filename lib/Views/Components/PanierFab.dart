import 'package:all4sport/Services/PanierState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class PanierFAB extends StatefulWidget {
  const PanierFAB({super.key});

  @override
  State<PanierFAB> createState() => _PanierFABState();
}

class _PanierFABState extends State<PanierFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      Navigator.pushNamedAndRemoveUntil(context, '/panier', (route) => false);
    }, child: Consumer<PanierState>(builder: (context, panierState, child) {
      return badges.Badge(
        position: badges.BadgePosition.topEnd(top: -15, end: -12),

        badgeContent: Text(panierState.panier.length.toString(), style: const TextStyle(color: Colors.deepOrange)),
        badgeAnimation: const badges.BadgeAnimation.rotation(),
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.white,

        ),
        child: const Icon(Icons.shopping_cart),
      );
    }));
  }
}
