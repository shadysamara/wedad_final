import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedad_ecommerce/models/product_request_model.dart';
import 'package:wedad_ecommerce/models/user_model.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addNewUserToFirestore(UserModel userModel) async {
    await firestore
        .collection('Users')
        .doc(userModel.id)
        .set(userModel.toMap());
  }

  Future<UserModel> getUsersFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await firestore.collection('Users').doc(id).get();
    UserModel userModel = UserModel.fromMap(data.data()!);
    return userModel;
  }

  deleteUserFromFirestore(String id) async {
    firestore.collection('Users').doc(id).delete();
  }

  updateUserInFirestore(UserModel userModel) async {
    firestore.collection('Users').doc(userModel.id).update(userModel.toMap());
  }

  Future<String?> addProductToFirestore(ProductRequest productRequest) async {
    try {
      DocumentReference<Map<String, dynamic>> doc =
          await firestore.collection('Products').add(productRequest.toMap());
      return doc.id;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<List<ProductRequest>> getAllProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('Products')
        .orderBy('creaed_at', descending: true)
        .get();
    List<ProductRequest> products = querySnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data();
      data['id'] = e.id;
      return ProductRequest.fromMap(data);
    }).toList();
    return products;
  }

  deleteProductFromFirestore(String productId) async {
    await firestore.collection('Products').doc(productId).delete();
  }

  updateProduct(ProductRequest productRequest) async {
    await firestore
        .collection('Products')
        .doc(productRequest.id)
        .update(productRequest.toMap());
  }
}
