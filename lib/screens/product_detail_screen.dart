import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_detail.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
  

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),

        // Icon that shows the cart
        actions: <Widget>[
           Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],

      ),

      body: ProductDetail(loadedProduct.imageUrl,loadedProduct.price,loadedProduct.id,loadedProduct.title,loadedProduct), 
      
      // body: ListView.builder(itemBuilder: (ctx, index){
      //   return  ProductDetail(loadedProduct.imageUrl);
      // },
      // itemCount: 1,
      // ) 
     
    );
  }
}
