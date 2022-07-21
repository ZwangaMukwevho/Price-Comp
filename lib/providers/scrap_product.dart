import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScrapProduct with ChangeNotifier {
  final String id;
  final String title;
  final String promotion;
  final String promotionPrice;
  final String currentPrice;
  final String imageUrl;
  int isFavorite;

  ScrapProduct({
    @required this.id,
    @required this.title,
    @required this.promotion,
    @required this.promotionPrice,
    @required this.currentPrice,
    @required this.imageUrl,
    @required this.isFavorite,
  });

  //Method for re-rolling value of favorite item when an error occured
  void _setFavValue(int newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    // print(isFavorite);

    // Change the is favorite variable
    final originalValue = isFavorite;
    if (isFavorite == 0) {
      isFavorite = 1;
    } else {
      isFavorite = 0;
    }
    notifyListeners();

    // Link of url of product
    final url =
        'https://shoppingappflutter-9c12b.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );

      // If there's an error when trying to update on the server
      if (response.statusCode >= 400) {
        _setFavValue(originalValue);
      }
    } catch (error) {
      _setFavValue(originalValue);
    }
  }
}
