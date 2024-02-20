import 'package:all4sport/Services/PanierState.dart';
import 'package:all4sport/Views/Components/BottomBar.dart';
import 'package:all4sport/Views/Components/PanierArticleView.dart';
import 'package:all4sport/Views/Components/PanierFab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanierScreen extends StatelessWidget {
  const PanierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Mon panier',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            height: 3,
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[200],
          ),
          Expanded(
            child: Consumer<PanierState>(
              builder: (context, panierState, child) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return PanierArticleView(article: panierState.panier[index]);
                    },
                    itemCount: panierState.panier.length);
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                //TODO: Faire la logique pour valider le panier.
              },
              child: Text('Valider le panier'))
        ]),
      ),
      bottomNavigationBar: const BottomBar(selectedTab: 3),
    );
  }
}
