import 'package:flutter/material.dart';
import 'package:product_list_app/model/cart_item.dart';
import 'package:product_list_app/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get totalPrice =>
      _cartItems.fold(0, (total, item) => total + item.product.price * item.quantity);

  void addToCart(Product product) {
    final existingCartItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingCartItem.quantity > 0) {
      existingCartItem.quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    final existingCartItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (quantity > 0) {
      existingCartItem.quantity = quantity;
    } else {
      removeFromCart(product);
    }

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
