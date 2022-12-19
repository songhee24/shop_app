import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

import '../screens/user_peoducts_screen.dart';

///  Created by mac on 16/12/22.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Hello Friend!'),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text(
              'Orders',
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  OrdersScreen.routeName, (Route route) => route.isFirst);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(
              'Manage Products',
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  UserProductsScreen.routeName, (Route route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
