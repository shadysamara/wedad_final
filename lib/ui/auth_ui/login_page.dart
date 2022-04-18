import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/providers/auth_provider.dart';
import 'package:wedad_ecommerce/ui/auth_ui/register_page.dart';
import 'package:wedad_ecommerce/widgets/custom_button.dart';
import 'package:wedad_ecommerce/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  goToRegisterPage() {
    NavigationHelper.navigationHelper
        .navigateToWidgetWithReplacement(RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, y) {
        return Column(
          children: [
            CustomTextField(provider.emailController, 'Enter the Email',
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
            CustomTextField(provider.passwordController, 'Enter the Password',
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
            CustomButton('Login', provider.getOneUserFromFirestore),
            CustomButton(
                'Create New Account', goToRegisterPage, Colors.orangeAccent)
          ],
        );
      }),
    );
  }
}
