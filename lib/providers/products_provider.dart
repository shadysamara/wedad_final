import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedad_ecommerce/data_respositories/firestore_data.dart';
import 'package:wedad_ecommerce/data_respositories/fitrstorage_helper.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/models/product_request_model.dart';
import 'package:wedad_ecommerce/ui/home/admin_home.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    getAllProducts();
  }
  ProductRequest? selectedProduct;
  File? pickedFile;
  pickFileFromMobile() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.pickedFile = File(file!.path);
    notifyListeners();
  }

  List<ProductRequest>? products;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDiscController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  addProduct() async {
    String imageUrl =
        await FirestorageHelper.firestorageHelper.upladNewImage(pickedFile!);
    ProductRequest productRequest = ProductRequest(
        timestamp: Timestamp.fromDate(DateTime.now()),
        imageUrl: imageUrl,
        name: productNameController.text,
        description: productDiscController.text,
        price: productPriceController.text);
    String? id = await FirestoreHelper.firestoreHelper
        .addProductToFirestore(productRequest);
    if (id != null) {
      showDialog(
          context:
              NavigationHelper.navigationHelper.navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () {
                      getAllProducts();
                      NavigationHelper.navigationHelper
                          .navigateToWidgetAndRemoveAll(AdminHomeScreen());
                    },
                    child: Text('ok'))
              ],
              content: Text('your ptoduct has been added successfully'),
            );
          });
    }
  }

  deleteProduct(String id, String imageUrl) async {
    await FirestorageHelper.firestorageHelper.deleteImageFromStorage(imageUrl);
    await FirestoreHelper.firestoreHelper.deleteProductFromFirestore(id);

    showDialog(
        context: NavigationHelper.navigationHelper.navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    getAllProducts();
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
            content: Text('your ptoduct has been deleted successfully'),
          );
        });
  }

  getAllProducts() async {
    products = await FirestoreHelper.firestoreHelper.getAllProducts();
    notifyListeners();
  }

  updateProduct() async {
    String imageUrl = selectedProduct!.imageUrl!;
    if (pickedFile != null) {
      imageUrl =
          await FirestorageHelper.firestorageHelper.upladNewImage(pickedFile!);
    }
    ProductRequest newProduct = ProductRequest(
        imageUrl: imageUrl,
        name: productNameController.text,
        description: productDiscController.text,
        id: selectedProduct!.id,
        price: productPriceController.text);
    await FirestoreHelper.firestoreHelper.updateProduct(newProduct);
    showDialog(
        context: NavigationHelper.navigationHelper.navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    getAllProducts();
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
            content: Text('your ptoduct has been updated successfully'),
          );
        });
  }
}
