import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/models/user_model.dart';
import 'package:wedad_ecommerce/providers/auth_provider.dart';
import 'package:wedad_ecommerce/ui/auth_ui/login_page.dart';
import 'package:wedad_ecommerce/widgets/custom_button.dart';
import 'package:wedad_ecommerce/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  goToLoginPage() {
    NavigationHelper.navigationHelper
        .navigateToWidgetWithReplacement(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Consumer<AuthProvider>(
        builder: (X,provider,y) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(provider.emailController,'Enter the Email',
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                CustomTextField(provider.passwordController, 'Enter the Password',
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                     CustomTextField(provider.nameController, 'Enter Your Name',
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
              CustomTextField(provider.cityController, 'Enter your city',
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                   CustomTextField(provider.ageController, 'Enter your age',
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
          Row(children: [
            Expanded(
              child: RadioListTile<Gender>(value: Gender.Male, groupValue: provider.gender, onChanged: (v){
              provider.changeGender(v!);
            },title: Text('Male'),),
            ),
          Expanded(
            child:   RadioListTile<Gender>(value: Gender.Female, groupValue: provider.gender, onChanged: (v){
            
              provider.changeGender(v!);
            
            },title: Text('FeMale'),),
          )
          ],),
                CustomButton('Register', provider.addNewUserToFirestore),
                
                  CustomButton('Already have Account', goToLoginPage,Colors.orangeAccent)
            
              ],
            ),
          );
        }
      ),
    );
  }
}
