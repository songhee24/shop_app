import 'package:flutter/material.dart';

///  Created by mac on 15/12/22.
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('1'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
