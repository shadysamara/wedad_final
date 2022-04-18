import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedad_ecommerce/data_respositories/auth_data.dart';
import 'package:wedad_ecommerce/data_respositories/firestore_data.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/models/user_model.dart';
import 'package:wedad_ecommerce/ui/auth_ui/login_page.dart';
import 'package:wedad_ecommerce/ui/home/admin_home.dart';
import 'package:wedad_ecommerce/ui/home/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  Gender gender = Gender.Male;
  changeGender(Gender gender) {
    this.gender = gender;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  UserModel? loggedUser;
  addNewUserToFirestore() async {
    String? uiserId = await FireAuthHelper.fireAuthHelper
        .register(emailController.text, passwordController.text);
    if (uiserId != null) {
      UserModel userModel = UserModel(
          name: nameController.text,
          age: num.parse(ageController.text),
          city: cityController.text,
          email: emailController.text,
          gender: gender,
          password: passwordController.text);
      userModel.id = uiserId;
      await FirestoreHelper.firestoreHelper.addNewUserToFirestore(userModel);
      emailController.clear();
      passwordController.clear();
      cityController.clear();
      ageController.clear();

      NavigationHelper.navigationHelper
          .navigateToWidgetWithReplacement(LoginScreen());
    }
  }

  getOneUserFromFirestore() async {
    String? id = await FireAuthHelper.fireAuthHelper
        .login(emailController.text, passwordController.text);
    if (id != null) {
      UserModel userModel =
          await FirestoreHelper.firestoreHelper.getUsersFromFirestore(id);
      loggedUser = userModel;
      notifyListeners();
      if(userModel.isAdmin!){
        NavigationHelper.navigationHelper
            .navigateToWidgetWithReplacement(AdminHomeScreen());
      }else{
        NavigationHelper.navigationHelper
            .navigateToWidgetWithReplacement(HomeScreen());
      }
      
    }
  }

  updateUserFromFirestore() async {
    UserModel userModel = UserModel(
        name: nameController.text,
        age: num.parse(ageController.text),
        city: cityController.text,
        email: loggedUser!.email!,
        gender: gender,
        password: '');
    userModel.id = FirebaseAuth.instance.currentUser!.uid;
    loggedUser = userModel;
    notifyListeners();
    await FirestoreHelper.firestoreHelper.updateUserInFirestore(userModel);
  }
}
