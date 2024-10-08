import 'package:flutter/material.dart';
import 'package:product_list_app/view/cart_screen/widgets/cart_item_card.dart';
import 'package:product_list_app/view/cart_screen/widgets/total_price_footer.dart';
import 'package:provider/provider.dart';
import 'package:product_list_app/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartProvider.cartItems[index];
                      return CartItemCard(cartItem: cartItem);
                    },
                  ),
                ),
                TotalPriceFooter(totalPrice: cartProvider.totalPrice),
              ],
            ),
    );
  }
}



