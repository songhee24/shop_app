import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String description;
  final String title;
  final double price;
  final String imageUrl;
  late bool isFavorite;

  ProductProvider({
    required this.id,
    required this.description,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
