import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/scrap_products.dart';
import '../providers/products.dart';
import './product_item.dart';
import './product_details.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    // final products = showFavs ? productsData.favoriteItems : productsData.items;

    final productsData = Provider.of<ScrapProducts>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    ;

    return GridView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => products[i],
        value: products[i],
        child: ProductDetails(
            // products[i].id,
            // products[i].title,s
            // products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
