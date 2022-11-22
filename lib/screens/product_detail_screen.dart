import 'package:flutter/material.dart';

///  Created by mac on 22/11/22.
class ProductDetailScreen extends StatelessWidget {
  final String title;

  const ProductDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
