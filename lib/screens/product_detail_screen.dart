import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
