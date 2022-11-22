import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_grid.dart';

///  Created by mac on 20/11/22.
class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Shop',
        ),
      ),
      body: ProductsGrid(),
    );
  }
}
