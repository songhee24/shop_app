import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as oi;

///  Created by mac on 16/12/22.
class OrderItem extends StatelessWidget {
  final oi.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${orderItem.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(orderItem.dateTime),
            ),
          )
        ],
      ),
    );
  }
}
