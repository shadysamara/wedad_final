import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRequest {
  String? id;
  String? name;
  String? description;
  String? price;
  String? imageUrl;
  Timestamp? timestamp;
  ProductRequest(
      {
        this.id,
        required this.imageUrl,
      required this.name,
      required this.description,
      required this.price,
      this.timestamp});
  ProductRequest.fromMap(Map<String, dynamic> map) {
    id = map['id'];
     description = map['description'];
    imageUrl = map['imageUrl'];
    name = map['name'];
    price = map['price'];
  }
  toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'creaed_at': timestamp
    };
  }
}
