import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

///  Created by mac on 15/12/22.
class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem({
    super.key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              spreadRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text(
                    'Are you sure ?',
                  ),
                  content: const Text(
                    'Do you want to remove the item from cart ?',
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              Provider.of<CartProvider>(context, listen: false)
                  .removeItem(productId);
            },
            key: UniqueKey(),
            background: Container(
              padding: const EdgeInsets.only(
                right: 16,
              ),
              color: Theme.of(context).colorScheme.error,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.all(0),
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
          ),
        ),
      ),
    );
  }
}
