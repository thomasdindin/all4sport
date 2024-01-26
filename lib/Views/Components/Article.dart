import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  var productName;
  var productImage;
  var productPrice;

  Article({super.key, required this.productName, this.productPrice, this.productImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(productImage), // Loaded from the network
          Text(productName),
          Text(productPrice),
        ],
      ),
    );
  }
}
