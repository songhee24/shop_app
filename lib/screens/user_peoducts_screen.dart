import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

///  Created by mac on 19/12/22.
class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsData =
        Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: () {},
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
