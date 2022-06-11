import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';
import './scrap_product.dart';

class ScrapProducts with ChangeNotifier {
  // Token property and UserId
  final String authToken;
  final String userId;

  // Constructor that gets authToken and UserId
  ScrapProducts(this.authToken, this.userId, this._items);

  List<ScrapProduct> _items = [];
  // var _showFavoritesOnly = false;

  List<ScrapProduct> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<ScrapProduct> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  ScrapProduct findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts(String shop,
      [bool filterByUser = false]) async {
    // Only filter by user if filterByUser argument is sent to true
    final fiterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shoppingappflutter-9c12b.firebaseio.com/product/picknpay/bakery.json?auth=$authToken';

    // Use a try and catch incase the http method fails
    try {
      // Use an http get method to get the products from firebase
      final response = await http.get(url);

      // Decoding the Json response
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      // Fetching favorite status
      // url =
      //     'https://shoppingappflutter-9c12b.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      // final favoriteResponse = await http.get(url);
      // final favoriteData = json.decode(favoriteResponse.body);

      final List<ScrapProduct> loadedProducts = [];

      // Converting the extracted data in json to a product object.
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          ScrapProduct(
            id: prodId,
            title: prodData['title'],
            promotion: prodData['promotion'],
            currentPrice: prodData['currentPrice'],
            promotionPrice: prodData['promotionPrice'],
            imageUrl: prodData['imageUrl'],
            isFavorite: false,
            // isFavorite: favoriteData == 0 ? false : true,
          ),
        );
      });

      // Load the products to item list and notify listeners after this is done
      print("throw error");
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print("throw error");
      throw (error);
    }
  }

  Future<void> addProduct(ScrapProduct product) {
    // Making an http request to add data to the database when we add a new product
    final url =
        'https://shoppingappflutter-9c12b.firebaseio.com/products.json?auth=$authToken';

    // Http post request that adds data to firebase
    return http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.promotionPrice,
        'imageUrl': product.imageUrl,
        'currentPrice': product.currentPrice,
        'creatorId': userId,
      }),
    )
        .then((response) {
      // Only add final product once done with the http post
      final newProduct = ScrapProduct(
        title: product.title,
        promotionPrice: product.promotionPrice,
        promotion: product.promotion,
        currentPrice: product.currentPrice,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();

      // Catching an error if the is a problem when posting the a product on firebase
      // It handles errors that could happen that occur on the post block or then block above
    }).catchError((error) {
      throw error;
    });
  }

  // Method to update a product on the server when it is edited
  Future<void> updateProduct(String id, ScrapProduct newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      // Url that goes to specific product based on ID
      final url =
          'https://shoppingappflutter-9c12b.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(
        url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.promotionPrice,
          'imageUrl': newProduct.imageUrl,
          'currentPrice': newProduct.currentPrice,
        }),
      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  // Method to delete a product from the server
  Future<void> deleteProduct(String id) async {
    // Url that goes to specific product based on ID
    final url =
        'https://shoppingappflutter-9c12b.firebaseio.com/products/$id.json?auth=$authToken';

    // Creating a copy of the product and deleting it from the list
    final productCopyIndex = _items.indexWhere((prod) => prod.id == id);

    // Delete the product, If there's an error exist the product to the items list agai n

    var productCopy = _items[productCopyIndex];
    _items.removeAt(productCopyIndex);

    final response = await http.delete(url);

    // Error when accessing server from http requests are thrown in the then block when using delete,
    // There use status codes to catch the errors
    if (response.statusCode >= 400) {
      _items.insert(productCopyIndex, productCopy);
      notifyListeners();
      // If the status code is greter then 400 than an error occurd
      throw HttpException('Error occurred when deleting product');
    }
    //If the delete succeeds
    productCopy = null;

    notifyListeners();
  }
}
