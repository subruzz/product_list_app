import 'package:flutter/material.dart';
import 'package:product_list_app/providers/auth_provider.dart';
import 'package:product_list_app/providers/cart_provider.dart';
import 'package:product_list_app/providers/prodcuct_provider.dart';
import 'package:product_list_app/utils/shared_widgets/messenger.dart';
import 'package:product_list_app/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider()..loadProducts(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'New Project',
        scaffoldMessengerKey: Messenger.scaffoldKey,
        theme: ThemeData(primaryColor: Colors.black),
        home: const SplashScreen(),
      ),
    );
  }
}
