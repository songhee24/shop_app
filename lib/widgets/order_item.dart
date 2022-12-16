import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as oi;

///  Created by mac on 16/12/22.
class OrderItem extends StatelessWidget {
  final oi.OrderItem orderItem;

  const OrderItem(this.orderItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${orderItem.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
