import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:show_if/show_if.dart';

import '../providers/scrap_product.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scrapProduct = Provider.of<ScrapProduct>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 20,
                offset: Offset(0, 5))
          ]),
      child: Column(
        children: [
          Container(
              // height: 320,
              margin: EdgeInsets.only(top: 10),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                      child: Image.network(scrapProduct.imageUrl,
                          fit: BoxFit.cover)),
                  if (scrapProduct.promotion != "")
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                scrapProduct.promotion,
                                style: TextStyle(
                                  fontSize: 10,
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Lato',
                                  // backgroundColor: Colors.greenAccent[700],
                                ),
                              ),
                            ),
                          )),
                    )
                ],
              )),
          // SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 0, 6.0, 0.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    scrapProduct.title,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      scrapProduct.promotionPrice == "R0.00"
                          ? Text(
                              scrapProduct.currentPrice,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            )
                          : Text(
                              scrapProduct.currentPrice,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14,
                                  color: Colors.grey.shade600),
                            ),
                      ShowIf(
                          condition: scrapProduct.promotionPrice != 0,
                          child: Text(
                            scrapProduct.promotionPrice.toString(),
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    scrapProduct.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    // product.toggleFavoriteStatus(authData.token, authData.userId);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    // cart.addItem(product.id, product.price, product.title);
                    // Scaffold.of(context).hideCurrentSnackBar();
                    // Scaffold.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text(
                    //       'Added item to cart!',
                    //     ),
                    //     duration: Duration(seconds: 2),
                    //     action: SnackBarAction(
                    //       label: 'UNDO',
                    //       onPressed: () {
                    //         cart.removeSingleItem(product.id);
                    //       },
                    //     ),
                    //   ),
                    // );
                  },
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
          // SizedBox(height: 20),
        ],
      ),
    );
  }
}
