import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/ui/auth_ui/register_page.dart';
import 'package:wedad_ecommerce/ui/home/admin_home.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((v) {
      bool result = FirebaseAuth.instance.currentUser == null;
      if (result) {
        NavigationHelper.navigationHelper
            .navigateToWidgetWithReplacement(RegisterScreen());
      } else {
        NavigationHelper.navigationHelper
            .navigateToWidgetWithReplacement(AdminHomeScreen());
       
      }
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
