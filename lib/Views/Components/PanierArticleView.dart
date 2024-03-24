import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Services/PanierState.dart';
import 'package:all4sport/Views/ArticleScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanierArticleView extends StatelessWidget {
  final Article article;
  const PanierArticleView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ArticleScreen(articleRef: article.productReference),
              ),
            );
          });
        },
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/"+article.imageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        article.productName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${article.productPrice}€',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

              ),
              Consumer<PanierState>(
                builder: (context, panierState, child) {
                  return IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red,),

                    onPressed: () {
                      panierState.removeFromPanier(article);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
