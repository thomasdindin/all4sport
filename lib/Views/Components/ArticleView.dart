import 'package:flutter/material.dart';
import '../../Objects/Article.dart' as product;
import '../ArticleScreen.dart';

class ArticleView extends StatelessWidget {
  final product.Article article;

  const ArticleView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        height: 200,
        width: 170,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.network("https://picsum.photos/200"),
            ), // Loaded from the network
            const SizedBox(height: 10),
            Text(
              article.productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('${(article.productPrice.toString())}€'),
          ],
        ),
      ),
    );
  }
}
