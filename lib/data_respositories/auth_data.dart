import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';

class FireAuthHelper {
  FireAuthHelper._();
  static FireAuthHelper fireAuthHelper = FireAuthHelper._();
  Future<String?> register(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
            context:
                NavigationHelper.navigationHelper.navigatorKey.currentContext!,
            builder: (context) {
              return AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('ok'))
                ],
                content: Text('The password provided is too weak.'),
              );
            });
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context:
                NavigationHelper.navigationHelper.navigatorKey.currentContext!,
            builder: (context) {
              return AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('ok'))
                ],
                content: Text('The account already exists for that email.'),
              );
            });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context:
                NavigationHelper.navigationHelper.navigatorKey.currentContext!,
            builder: (context) {
              return AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('ok'))
                ],
                content: Text('No user found for that email.'),
              );
            });
      } else if (e.code == 'wrong-password') {
        showDialog(
            context:
                NavigationHelper.navigationHelper.navigatorKey.currentContext!,
            builder: (context) {
              return AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('ok'))
                ],
                content: Text('Wrong password provided for that user.'),
              );
            });
      }
    }
  }

  logOut() async {
    FirebaseAuth.instance.signOut();
  }
}
