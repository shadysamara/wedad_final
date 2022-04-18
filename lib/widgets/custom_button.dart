import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Color color;
  String title;
  Function function;
  CustomButton(this.title, this.function, [this.color = Colors.blue]);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(title,style: const TextStyle(fontSize: 20,color: Colors.white),),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
