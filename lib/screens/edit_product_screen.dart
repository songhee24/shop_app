import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/providers/products_provider.dart';

///  Created by mac on 19/12/22.
class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formGlobalKey = GlobalKey<FormState>();
  late Color _isImageValue = Colors.grey;

  var _isInit = true;
  var _editedProduct = ProductProvider(
      id: '',
      description: '',
      title: '',
      price: 0,
      imageUrl: '',
      isFavorite: false);

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      final product =
          Provider.of<ProductsProvider>(context).findById(productId);
      _editedProduct = product;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    final imageUrl = _imageUrlController.text;
    if (!_imageUrlFocusNode.hasFocus) {
      if (imageUrl.isEmpty ||
          !imageUrl.startsWith('http') ||
          !imageUrl.startsWith('https')) {
        return;
      }
    }
    setState(() {});
  }

  void _saveForm() {
    final isValid = _formGlobalKey.currentState?.validate();
    setState(() {
      _isImageValue =
          _imageUrlController.text.isEmpty ? Colors.red : Colors.grey;
    });
    if (!isValid!) {
      return;
    }
    _formGlobalKey.currentState?.save();
    Provider.of<ProductsProvider>(context, listen: false)
        .addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formGlobalKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  validator: (value) {
                    return value!.isEmpty ? 'Please provide value.' : null;
                  },
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = ProductProvider(
                        id: _editedProduct.id,
                        description: _editedProduct.description,
                        title: value!,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Price',
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).errorColor,
                        ),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Price.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter number greater than 0';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = ProductProvider(
                        id: _editedProduct.id,
                        description: _editedProduct.description,
                        title: _editedProduct.title,
                        price: double.parse(value!),
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description.';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long.';
                    }
                    return null;
                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _editedProduct = ProductProvider(
                        id: _editedProduct.id,
                        description: value!,
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: _isImageValue,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter Url')
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageUrlController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Image URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an image Url';
                          }
                          if (!value.startsWith('http') ||
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = ProductProvider(
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              imageUrl: value!,
                              isFavorite: _editedProduct.isFavorite);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
