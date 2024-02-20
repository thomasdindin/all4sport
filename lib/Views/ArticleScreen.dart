import 'dart:developer';

import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Services/PanierState.dart';
import 'package:all4sport/Services/StateManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatelessWidget {
  final String articleRef;
  const ArticleScreen({super.key, required this.articleRef});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.getInstance();

    try {
      var article = appState.getArticleByRef(articleRef);

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(article.productName),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    article.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${(article.productPrice.toString())}€'),
                      const SizedBox(height: 10),
                      Text(
                        article.productDescription,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          child: Consumer<PanierState>(
                            builder: (context, panierState, child) {
                              return ElevatedButton(
                                  onPressed: () {
                                    panierState.addToPanier(article);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ajouter au panier'));
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      log("Erreur lors de la récupération de l'article : $e");

      return Scaffold(
        appBar: AppBar(
          title: const Text('Article'),
        ),
        body: Center(
          child: Text('Article $articleRef not found'),
        ),
      );
    }
  }
}
