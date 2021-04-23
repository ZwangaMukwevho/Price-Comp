import 'package:flutter/material.dart';

import '../models/categories.dart';
import "../widgets/app_drawer.dart";
import "../widgets/shop_item.dart";

class ShopsScreen extends StatelessWidget {

   static const routeName = '/shops-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
      ),

      // Adding drawer icon to screen
      drawer: AppDrawer(),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: SHOPSLIST
            .map(
              (catData) => ShopItem(
                    catData.id,
                    catData.title,
                    catData.color,
                    catData.imageName,
                  ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}