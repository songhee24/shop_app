import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/configs/Apis.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String description;
  final String title;
  final double price;
  final String imageUrl;
  late bool isFavorite;

  @override
  String toString() {
    return 'ProductProvider{id: $id, description: $description, title: $title, price: $price, imageUrl: $imageUrl, isFavorite: $isFavorite}';
  }

  ProductProvider({
    required this.id,
    required this.description,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  void _setFavoriteStatus(bool status) {
    isFavorite = status;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.https(
      Apis.baseUrl,
      Apis.generateUserFavoritesApi(userId, id),
      {'auth': token},
    );
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        _setFavoriteStatus(oldStatus);
      }
    } catch (onError) {
      _setFavoriteStatus(oldStatus);
    }
  }
}
