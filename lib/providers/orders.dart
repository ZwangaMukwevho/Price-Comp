import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  // We get the orders and authToken from the orders constructor
  Orders(this.authToken,this.userId,this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

// Method to fetch orders from the database server
  Future<void> fetchAndSetOrders() async {
    final url = 'https://shoppingappflutter-9c12b.firebaseio.com/orders/$userId.json?auth=$authToken';

        final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId, 
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      title: item['title'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
    // final response = await http.get(url);
     

    // // List of orderd items
    // final List<OrderItem> loadedOrders = [];
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;
    
    // // If there is no extracted data
    // if(extractedData == null){
    //   return;
    // }

    // // Looping through the ordered items from the json response and putting them in the loadedOrders list
    // extractedData.forEach((orderId, orderData) {
    //   loadedOrders.add(
    //     OrderItem(
    //       id: orderId,
    //       amount: orderData['amount'],
    //       products: (orderData['products'] as List<dynamic>)
    //           .map((item) => CartItem(
    //               id: item['id'],
    //               price: item['price'],
    //               quantity: item['quantity'],
    //               title: item['title'],),    
    //               )
    //           .toList(),
    //       dateTime: DateTime.parse(orderData['dataTime']),
    //     ),
    //   ); 
    // });

    // _orders = loadedOrders.reversed.toList();
    // notifyListeners(); 
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://shoppingappflutter-9c12b.firebaseio.com/orders/$userId.json?auth=$authToken';

    // Time in which order was placed
    final orderTime = DateTime.now();

    try {
      // Posting the orders to the database server
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': orderTime.toIso8601String(),

          // Converting the list of cartproducts that consists of cartItem object into a map that can be stored in firebase
          'products': cartProducts
              .map((itemInCart) => {
                    'id': itemInCart.id,
                    'price': itemInCart.price,
                    'quantity': itemInCart.quantity,
                    'title': itemInCart.title,
                  })
              .toList(),
        }),
      );

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: orderTime,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
