import 'package:flutter/material.dart';

class ProductsState extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
