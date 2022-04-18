import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestorageHelper {
  FirestorageHelper._();
  static FirestorageHelper firestorageHelper = FirestorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<String> upladNewImage(File file) async {
    String fileName = file.path.split('/').last;
    Reference reference = firebaseStorage.ref('products/$fileName');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  deleteImageFromStorage(String imageUrl) async{
    Reference reference = firebaseStorage.refFromURL(imageUrl);
    await reference.delete();
  }
  
}
