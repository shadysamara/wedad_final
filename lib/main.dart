import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/providers/auth_provider.dart';
import 'package:wedad_ecommerce/providers/products_provider.dart';
import 'package:wedad_ecommerce/ui/auth_ui/splach_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) {
        return AuthProvider();
      }),
        ChangeNotifierProvider<ProductProvider>(create: (context) {
        return ProductProvider();
      })
    ],
    child: MaterialApp(
        navigatorKey: NavigationHelper.navigationHelper.navigatorKey,
        home: SplachScreen()),
  ));
}
