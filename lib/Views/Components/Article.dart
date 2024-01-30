import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  String productName;
  String productImage;
  int productPrice;

  Article({super.key, required this.productName, required this.productPrice, required this.productImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: Card(
        color: Colors.white,
        borderOnForeground: false,
        child: Column(
          children: [
            Image.network(productImage), // Loaded from the network
            Text(
                productName
                , style: const TextStyle(
              fontWeight: FontWeight.bold,

            ),
            ),
            Text(productPrice.toString()),
          ],
        ),
      ),
    );
  }
}
