import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedad_ecommerce/data_respositories/auth_data.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/models/user_model.dart';
import 'package:wedad_ecommerce/providers/auth_provider.dart';
import 'package:wedad_ecommerce/providers/products_provider.dart';
import 'package:wedad_ecommerce/ui/auth_ui/login_page.dart';
import 'package:wedad_ecommerce/ui/home/add_new_product.dart';
import 'package:wedad_ecommerce/ui/home/location_screen.dart';
import 'package:wedad_ecommerce/ui/home/update_product.dart';
import 'package:wedad_ecommerce/widgets/custom_button.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationHelper.navigationHelper
                .navigateToWidget(AddProductScreen());
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          actions: [
              IconButton(
                onPressed: () async {
                  await FireAuthHelper.fireAuthHelper.logOut();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LocationScreen();
                  }));
                },
                icon: Icon(Icons.gps_fixed)),
            IconButton(
                onPressed: () async {
                  await FireAuthHelper.fireAuthHelper.logOut();
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
                icon: Icon(Icons.logout))
          ],
          title: Text('Admin Home Screen'),
        ),
        body: Consumer<ProductProvider>(builder: (context, provider, x) {
          return provider.products == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : provider.products!.isEmpty
                  ? const Center(
                      child: Text('No Products Found'),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5),
                      itemCount: provider.products!.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              child: Image.network(
                                provider.products![index].imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        provider.deleteProduct(
                                            provider.products![index].id!,
                                            provider
                                                .products![index].imageUrl!);
                                      },
                                      icon: CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.3),
                                          child: Icon(Icons.delete))),
                                  IconButton(
                                      onPressed: () {
                                        provider.selectedProduct =
                                            provider.products![index];
                                        provider.productNameController.text =
                                            provider.products![index].name!;
                                        provider.productDiscController.text =
                                            provider
                                                .products![index].description!;
                                        provider.productPriceController.text =
                                            provider.products![index].price!;
                                        NavigationHelper.navigationHelper
                                            .navigateToWidget(
                                                UpdateProductScreen(provider
                                                    .products![index]
                                                    .imageUrl!));
                                      },
                                      icon: CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.3),
                                          child: Icon(Icons.edit))),
                                ],
                              ),
                            )
                          ],
                        );
                      });
        }));
  }
}

class ColumnItem extends StatelessWidget {
  final String label;
  final String value;
  ColumnItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              label + ': ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}
