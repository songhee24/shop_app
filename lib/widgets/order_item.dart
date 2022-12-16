import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as oi;

///  Created by mac on 16/12/22.
class OrderItem extends StatefulWidget {
  final oi.OrderItem orderItem;

  const OrderItem(this.orderItem, {super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expaned = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy/hh:mm').format(widget.orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expaned ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expaned = !_expaned;
                });
              },
            ),
          ),
          if (_expaned)
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              height: min(
                widget.orderItem.products.length * 20.0 + 40,
                100,
              ),
              child: ListView(
                children: widget.orderItem.products
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: Text(
                              e.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${e.quantity}x \$${e.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
