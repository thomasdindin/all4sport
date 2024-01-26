import 'package:flutter/material.dart';

class PanierFAB extends StatefulWidget {
  const PanierFAB({super.key});

  @override
  State<PanierFAB> createState() => _PanierFABState();
}

class _PanierFABState extends State<PanierFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/panier', (route) => false);
      },
      child: const Icon(Icons.shopping_cart),
    );
  }
}
