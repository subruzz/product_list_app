import 'package:flutter/material.dart';
import 'package:product_list_app/services/sharedpf.dart';
import 'package:product_list_app/view/cart_screen/cart_screen.dart';
import 'package:product_list_app/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:product_list_app/utils/shared_widgets/messenger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/prodcuct_provider.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productProvider = context.read<ProductProvider>();

    productProvider.addListener(() {
      if (productProvider.errorMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Messenger.showSnackBar(message: productProvider.errorMessage ?? '');
        });
      }
    });
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SharedPrefs.setLoggedOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ));
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                showLogoutDialog(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }
          if (provider.products == null || provider.products!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return ListView.builder(
            itemCount: provider.products!.length,
            itemBuilder: (context, index) {
              final product = provider.products![index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
