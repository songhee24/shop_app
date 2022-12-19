import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/go_back_button.dart';
import '../widgets/user_product_item.dart';
import 'edit_product_screen.dart';

///  Created by mac on 19/12/22.
class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsData =
        Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditproductScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(children: [
            UserProductItem(
              productsData.items[i].title,
              productsData.items[i].imageUrl,
            ),
            const Divider(),
          ]),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
