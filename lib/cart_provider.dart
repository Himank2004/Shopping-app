import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic>? product) {
    // Added a null check before adding the product to the cart
    if (product != null) {
      cart.add(product);
      notifyListeners();
    }
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}
