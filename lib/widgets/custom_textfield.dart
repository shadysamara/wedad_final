import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  EdgeInsets edgeInsets;
  CustomTextField(this.controller, this.label,this.edgeInsets);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: edgeInsets,
      child: TextField(
       
        controller: controller,
        decoration: InputDecoration(
            label: Text(label),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
