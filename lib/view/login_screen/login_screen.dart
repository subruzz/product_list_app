import 'package:flutter/material.dart';
import 'package:product_list_app/providers/auth_provider.dart';
import 'package:product_list_app/utils/shared_widgets/messenger.dart';
import 'package:product_list_app/utils/shared_widgets/text_field.dart';
import 'package:product_list_app/utils/validators/form_validator.dart';
import 'package:product_list_app/view/login_screen/widgets/auth_form.dart';
import 'package:provider/provider.dart';

import '../home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = context.read<AuthProvider>();
    authProvider.addListener(() {
      if (authProvider.errorMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Messenger.showSnackBar(message: authProvider.errorMessage ?? '');
        });
      }
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100]!, Colors.blue[400]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: AuthForm(
                      usernameController: _usernameController,
                      passwordController: _passwordController,
                      formKey: _formKey)),
            ),
          ),
        ),
      ),
    );
  }
}
