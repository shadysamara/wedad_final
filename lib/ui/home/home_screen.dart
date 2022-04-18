import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedad_ecommerce/data_respositories/auth_data.dart';
import 'package:wedad_ecommerce/helpers/navigation_helper.dart';
import 'package:wedad_ecommerce/models/user_model.dart';
import 'package:wedad_ecommerce/providers/auth_provider.dart';
import 'package:wedad_ecommerce/ui/auth_ui/login_page.dart';
import 'package:wedad_ecommerce/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: [
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
          title: Text('Home Screen'),
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return Column(
            children: [
              ColumnItem('Name', provider.loggedUser!.name!),
              ColumnItem('Email', provider.loggedUser!.email!),
              ColumnItem('City', provider.loggedUser!.city!),
              ColumnItem(
                  'Gender',
                  provider.loggedUser!.gender == Gender.Male
                      ? 'Male'
                      : 'Female'),
              ColumnItem('Age', provider.loggedUser!.age!.toString()),
                 ],
          );
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
