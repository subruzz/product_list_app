import 'package:flutter/material.dart';
import 'package:product_list_app/model/product_model.dart';
import 'package:product_list_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class QuantitySelector extends StatefulWidget {
  final Product product;

  const QuantitySelector({super.key, required this.product});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 20),
          onPressed: () {
            if (quantity > 0) {
              setState(() {
                quantity--;
              });
              cartProvider.updateQuantity(widget.product, quantity);
            }
          },
          color: Colors.blue[700],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue[700]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 14),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, size: 20),
          onPressed: () {
            if (quantity < 10) {
              setState(() {
                quantity++;
              });
              cartProvider.addToCart(widget.product);
            }
          },
          color: Colors.blue[700],
        ),
      ],
    );
  }
}
