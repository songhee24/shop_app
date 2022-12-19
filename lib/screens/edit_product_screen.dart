import 'package:flutter/material.dart';

///  Created by mac on 19/12/22.
class EditproductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditproductScreen({super.key});

  @override
  State<EditproductScreen> createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
