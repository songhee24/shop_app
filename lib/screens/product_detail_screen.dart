import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/providers/products_provider.dart';

///  Created by mac on 22/11/22.
class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';
  // final String title;

  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    final Product selectedItem =
        Provider.of<ProductsProvider>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem.title),
      ),
    );
  }
}
