import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

///  Created by mac on 20/11/22.
class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductProvider product =
        Provider.of<ProductProvider>(context, listen: false);
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<ProductProvider>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title,
            style: const TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              cart.addItem(
                product.id,
                product.price,
                product.title,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(
                    seconds: 2,
                  ),
                  content: const Text(
                    'Added Item to Cart!',
                  ),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
