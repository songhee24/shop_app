import 'package:flutter/material.dart';

///  Created by mac on 16/12/22.
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text(
              'shop',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text(
              'Orders',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
