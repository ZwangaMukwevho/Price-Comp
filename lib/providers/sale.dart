import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../providers/product.dart';
import '../providers/products.dart';

class Sale with ChangeNotifier {
  final String authToken;
  final String userId;

  Sale(this.authToken, this.userId);

  // List that hold items that are on sale
  List<Product> _saleItems = [];

  // Returns the list of sale items
  List<Product> get saleItems {
    return [..._saleItems];
  }

  // Adds products to the saleItmsList
  Future<void> addSale(Product product) {
    if (_saleItems.contains(product.title)) {
      return null;
    } else {
      //Url used to store the word
      final url =
          'https://shoppingappflutter-9c12b.firebaseio.com/sales.json?auth=$authToken';
      return http
          .post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      )
          .then(
        (response) {
          _saleItems.insert(0, product);
          notifyListeners();
        },
      ).catchError((error) {
        throw error;
      });
    }
  }

  // Method that fetches the sales and adds them to the list
  Future<void> fetchAndSetSales() async {
    // Url that fetches the products that are from a specifc user
    //final url = 'https://shoppingappflutter-9c12b.firebaseio.com/sales.json?auth=$authToken&orderBy="userId"&equalTo="$userId"';
    final url =
        'https://shoppingappflutter-9c12b.firebaseio.com/sales.json?auth=$authToken';

    // Using a try and getch to fetch the words
    try {
      final response = await http.get(url);

      //Decoding the JSON responce
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      final List<Product> extractedSales = [];
      //print(extractedData);
      // Converting the extracted data in json to the word list

      extractedData.forEach((prodId, prodData) {
        extractedSales.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: false,
          ),
        );
      });

      _saleItems = extractedSales;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
