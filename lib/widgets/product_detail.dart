import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class ProductDetail extends StatelessWidget {
  final String imageUrl;
  final double price;
  final String productId;
  final String title;
  final Product product;

  ProductDetail(
      this.imageUrl, this.price, this.productId, this.title, this.product);

  // Function that changes favorite status based on favorite status
  String favStatus(bool status) {
    if (status) {
      return "Marked as favorite";
    } else {
      return "Unmarked as favorite";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Media query variable
    final mediaQuery = MediaQuery.of(context);
    final cart = Provider.of<Cart>(context, listen: false);

    // Fetching the authentication token from the authentication provider
    final authData = Provider.of<Auth>(context, listen: false);

    // Lists of items that are to be on the cart
    final List<String> buttonList = ["Add to cart", "Favorite"];
    final List<IconData> iconList = [Icons.shopping_cart, Icons.favorite];

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Container to hold image
          Container(
            height: mediaQuery.size.width * 0.6,
            width: double.infinity,
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),

          Container(
             decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),),
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                //To do: Implement method that changes shop and price based on onTap method in container with prices with different shop
                'Selected: Checkers @ R18.99 ',
                
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),

          // Container that holds prices from different shops
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            height: mediaQuery.size.width * 0.7,
            width: mediaQuery.size.width - 20,
            child: ListView.builder(
              itemBuilder: (ctx, index) => GestureDetector(
                  onTap: (){
                    
                  },
                  child: Column(children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(' ${(index + 1)}'),
                    ),
                    title: Text("Checkers"),
                    subtitle: Text(
                      "sale",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 18),
                    ),
                    trailing: Text("\R${price.toStringAsFixed(2)}"),
                  ),
                  Divider(
                    color: Colors.orange,
                  )
                ]),
              ),
              itemCount: 5,
            ),
          ),

          // Container that will hold option to add to cart or add to favorites

          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              //border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(5),
            width: mediaQuery.size.width - 20,
            height: mediaQuery.size.width * 0.2,
            child: GridView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: 2,
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => {
                  // If cart button is pressed
                  if (i == 0)
                    {
                      cart.addItem(productId, price, title),
                      Scaffold.of(context).hideCurrentSnackBar(),
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added item to cart!',
                          ),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(productId);
                            },
                          ),
                        ),
                      ),
                    }
                  // If Favorite button is pressed
                  else if (i == 1)
                    {
                      product.toggleFavoriteStatus(
                          authData.token, authData.userId),
                      Scaffold.of(context).hideCurrentSnackBar(),
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            favStatus(product.isFavorite),
                          ),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              product.toggleFavoriteStatus(
                          authData.token, authData.userId);
                            },
                          ),
                        ),
                      ),
                    }
                },
                child: Card(
                  color: Colors.black87,
                  child: ListTile(
                    title: Text(buttonList[i],
                        style: TextStyle(color: Colors.white)),
                    trailing: IconButton(
                      icon: Icon(
                        iconList[i],
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
            ),
          ),
          // )
        ],
      ),
    );
  }
}
