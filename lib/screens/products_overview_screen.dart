import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_grid.dart';

///  Created by mac on 20/11/22.
class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Shop',
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (int selectedValue) {
              print(selectedValue);
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 0,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text('Show All'),
              )
            ],
          ),
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}
