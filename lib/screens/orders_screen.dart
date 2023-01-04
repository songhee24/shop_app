import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show OrdersProvider;
import '../widgets/go_back_button.dart';
import '../widgets/order_item.dart';

///  Created by mac on 16/12/22.
class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (context, dataSnapshot) {
          print(dataSnapshot.connectionState.toString());
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    dataSnapshot.error.toString(),
                  ),
                ),
              );
            } else {
              return Consumer<OrdersProvider>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(
                    orderData.orders[i],
                  ),
                  itemCount: orderData.orders.length,
                ),
              );
            }
            return Container();
          }
        },
      ),
    );
  }
}
