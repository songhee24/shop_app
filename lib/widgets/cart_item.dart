import 'package:flutter/material.dart';

///  Created by mac on 15/12/22.
class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const CartItem(
      {super.key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 2,
                ),
                child: Text(
                  '\$${price}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline2?.color,
                  ),
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
