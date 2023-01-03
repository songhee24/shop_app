import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/configs/Apis.dart';

import 'product_provider.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> _items = [
    // ProductProvider(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     isFavorite: false),
    // ProductProvider(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     isFavorite: false),
    // ProductProvider(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //     isFavorite: false),
    // ProductProvider(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //     isFavorite: false),
  ];

  // var _showFavoritesOnly = false;

  List<ProductProvider> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<ProductProvider> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  ProductProvider findById(String id) {
    return _items.firstWhere(
      (product) => product.id == id,
    );
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(Apis.baseUrl, Apis.getProductsApi);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<ProductProvider> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(ProductProvider(
          id: productId,
          description: productData['description'],
          title: productData['title'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      _items = loadedProducts;
    } catch (onError) {
      throw (onError);
    }
  }

  Future<void> addProduct(ProductProvider productProvider) async {
    final url = Uri.https(Apis.baseUrl, Apis.addProductApi);
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': productProvider.title,
            'description': productProvider.description,
            'imageUrl': productProvider.imageUrl,
            'price': double.parse(productProvider.price.toString()),
            'isFavorite': productProvider.isFavorite
          }));
      final newProduct = ProductProvider(
          id: json.decode(response.body)['name'],
          description: productProvider.description,
          title: productProvider.title,
          price: productProvider.price,
          imageUrl: productProvider.imageUrl,
          isFavorite: productProvider.isFavorite);
      _items.add(newProduct);
      notifyListeners();
    } catch (onError) {
      throw onError;
    }
  }

  Future<void> updateProduct(String id, ProductProvider newProduct) async {
    final url = Uri.https(Apis.baseUrl, Apis.getFiledById(id));
    final prodIndex = _items.indexWhere((element) => element.id == id);
    try {
      if (prodIndex >= 0) {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      }
    } catch (onError) {
      throw onError;
    }
  }

  void deleteProduct(String productId) {
    final url = Uri.https(Apis.baseUrl, Apis.getFiledById(productId));
    final existingProductIndex =
        _items.indexWhere((element) => element.id == productId);
    ProductProvider? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    http.delete(url).then((value) {
      existingProduct = null;
    }).catchError((onError) {
      _items.insert(existingProductIndex, existingProduct!);
      notifyListeners();
    });
  }
}
