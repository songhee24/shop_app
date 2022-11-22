import 'package:flutter/material.dart';

import '../models/Product.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
    required this.loadedProduct,
  }) : super(key: key);

  final List<Product> loadedProduct;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProduct.length,
      itemBuilder: (ctx, i) => ProductItem(
        id: loadedProduct[i].id,
        title: loadedProduct[i].title,
        imageUrl: loadedProduct[i].imageUrl,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
