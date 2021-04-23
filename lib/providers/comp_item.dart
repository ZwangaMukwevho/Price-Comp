import 'package:flutter/foundation.dart';

import '../providers/product.dart';

class CompItem {}

class Comp with ChangeNotifier {
  List<Product> _items1 = [];
  List<Product> _items2 = [];
  double _total1 = 0.0;
  double _total2 = 0.0;

  // Fetches the comparisons items from first column
  List<Product> get compItems1 {
    // Returns a new list with items,
    return [..._items1];
  }

  // Fetches the comparisons items from second column
  List<Product> get compItems2 {
    // Returns a new list with items,
    return [..._items2];
  }

  // Getter method that returns total price of items in list
  double get priceTotal1{
    return _total1;
  }

  // Getter method that returns total price of items in list
  double get priceTotal2{
    return _total2;
  }
  // Functions that gets to the fist column
  void addCompItem(Product product, int columnNo) {
    if (columnNo == 1) {
      // Add new compItem to list 1
      _items1.add(
        product,
      );
    } else if (columnNo == 2) {
      // Add new compItem to list 2
      _items2.add(
        product,
      );
    }
    notifyListeners();
  }

  void deleteCompItem(String productTitle, int columnNo){
    if(columnNo==1){

      try{
      final productIndex = _items1.indexWhere((prod)=> prod.title == productTitle);
      _items1.removeAt(productIndex);}
      catch(error){
        throw(error);
      }
    }
    else if(columnNo==2){
      try{
     final productIndex = _items2.indexWhere((prod)=> prod.title == productTitle);
      _items2.removeAt(productIndex); }
      catch(error){
        throw(error);
      }
    }
    notifyListeners();
  }

  // Functions that calculates total
  void listTotal(int columnNo) {
    if (columnNo == 1) {
      _total1 = 0.0;
      _items1.forEach(
        (prod) {
          _total1 = _total1 + prod.price;

        },
      );
    } else if (columnNo == 2) {
       _total2 = 0.0;
      _items2.forEach(
        (prod) {
          _total2 = _total2 + prod.price;
        },
      );
    }

    notifyListeners();
  }
}
