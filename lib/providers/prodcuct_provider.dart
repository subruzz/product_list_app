import 'package:flutter/material.dart';
import 'package:product_list_app/model/product_model.dart';
import 'package:product_list_app/services/product_service.dart';
import 'package:product_list_app/utils/erros/main_exception.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product>? _products;
  bool _isLoading = false;
  String? _errorMessage;

  List<Product>? get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.fetchProducts();
      _errorMessage = null;
    } on MainException catch (e) {
      _errorMessage = e.toString();
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
}
