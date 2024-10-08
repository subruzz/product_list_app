import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_list_app/providers/auth_provider.dart';
import 'package:product_list_app/utils/shared_widgets/text_field.dart';
import 'package:product_list_app/utils/validators/form_validator.dart';

class AuthForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const AuthForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey, // Use the passed-in form key
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag,
            size: 100,
            color: Colors.blue[700],
          ),
          const SizedBox(height: 48),
          Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 48),
          CustomTextField(
            label: 'Username',
            validator: Validator.validateName,
            controller: usernameController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Password',
            keyboardType: TextInputType.visiblePassword,
            validator: Validator.validatePassword,
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 24),
          Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          // Validate the form
                          String username = usernameController.text;
                          String password = passwordController.text;
                          provider.login(username, password);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: provider.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
