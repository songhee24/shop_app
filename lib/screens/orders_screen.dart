import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show OrdersProvider;
import '../widgets/go_back_button.dart';
import '../widgets/order_item.dart';

///  Created by mac on 16/12/22.
class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) async {
    // _isLoading = true;
    // Provider.of<OrdersProvider>(context, listen: false)
    //     .fetchAndSetOrders()
    //     .then((value) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }).catchError((onError) {

    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    // });
    super.initState();
  }

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
