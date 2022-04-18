import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedad_ecommerce/providers/products_provider.dart';
import 'package:wedad_ecommerce/widgets/custom_button.dart';
import 'package:wedad_ecommerce/widgets/custom_textfield.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('New Product')),
      body: Consumer<ProductProvider>(builder: (context, provider, x) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    provider.pickFileFromMobile();
                  },
                  child: provider.pickedFile == null
                      ? Container(
                          height: 200,
                          width: 200,
                          color: Colors.grey,
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          child: Image.file(
                            provider.pickedFile!,
                            fit: BoxFit.cover,
                          ))),
                          CustomTextField(provider.productNameController, 'product name', const EdgeInsets.symmetric(horizontal: 10,vertical: 5)),
                                                    CustomTextField(provider.productDiscController, 'product Description',
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                                            CustomTextField(provider.productPriceController, 'product price',
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                  Spacer(),
                  CustomButton('ADD PRODUCT', provider.addProduct)
            ],
          ),
        );
      }),
    );
  }
}
