import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/go_back_button.dart';
import '../widgets/user_product_item.dart';
import 'edit_product_screen.dart';

///  Created by mac on 19/12/22.
class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  Future<void> _navigateAndDisplaySelection(
      BuildContext context, dynamic productId) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.of(context)
        .pushNamed(EditProductScreen.routeName, arguments: productId);

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    print('result$result');
    if (result == null) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  Widget _renderUserProducts(productsData) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemBuilder: (_, i) => Column(children: [
          UserProductItem(
            productsData.allItems[i].title,
            productsData.allItems[i].imageUrl,
            id: productsData.allItems[i].id,
            navigateToEdit: _navigateAndDisplaySelection,
          ),
          const Divider(),
        ]),
        itemCount: productsData.allItems.length,
      ),
    );
  }

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
              _navigateAndDisplaySelection(context, null);
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: _renderUserProducts(productsData),
      ),
    );
  }
}
