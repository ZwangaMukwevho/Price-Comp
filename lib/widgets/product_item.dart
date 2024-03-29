import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';
import '../providers/scrap_product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context, listen: false);
    // final cart = Provider.of<Cart>(context, listen: false);
    final scrapProduct = Provider.of<ScrapProduct>(context, listen: false);

    // Fetching the authentication token from the authentication provider
    // final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: scrapProduct.id,
            );
          },
          child: Image.network(
            // product.imageUrl,
            scrapProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),

        // Holds the current price, old price and saved price
        header: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            // 'Save R50',
            scrapProduct.promotion.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          leading: Text(
            // '\R${product.price.toStringAsFixed(2)}',
            scrapProduct.currentPrice,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Text(
            // '\R${product.price.toStringAsFixed(2)}',
            scrapProduct.promotionPrice,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.lineThrough),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<ScrapProduct>(
            builder: (ctx, scrapProduct, _) => IconButton(
              icon: Icon(
                scrapProduct.isFavorite == 1
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                // product.toggleFavoriteStatus(authData.token, authData.userId);
              },
            ),
          ),
          title: Text(
            // product.title,
            scrapProduct.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
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
        ),
      ),
    ); // End of child
  }
}
