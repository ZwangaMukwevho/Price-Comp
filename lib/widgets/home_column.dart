import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_column_header_widget.dart';
import '../providers/sale.dart';
import '../models/categories.dart';

class HomeColumn extends StatelessWidget {

  // Widget that holds the sales
  Widget salesWidget(double widthSize, double heightSize, String title,
          double price, String shop, String promo, String imageUrl) =>
      Positioned(
        bottom: 0,
        top: 0,
        right: 25,
        left: 1,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        promo,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          //color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'R${price.toString()}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        shop,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.network(
              imageUrl,
              width: widthSize,
              height: heightSize,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      );

    
   
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final sales = Provider.of<Sale>(context);

    double widthSize = mediaQuery.size.width * 0.35;
    double heightSize = mediaQuery.size.width * 0.45;

    return Column(
      children: <Widget>[
        SizedBox(
          height: mediaQuery.size.height * 0.03,
        ),

        //Row that holds title and see all
        HomeColumnHeaderWidget("Top deals", "See all"),

        SizedBox(
          height: mediaQuery.size.height * 0.01,
        ),

      
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height * 0.2,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: sales.saleItems.length,
            itemBuilder: (ctx, index) => Stack(
              children: [
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.width * 0.4,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.purple, Colors.blue]),
                  ),
                ),
                salesWidget(
                  widthSize,
                  heightSize,
                  sales.saleItems[index].title,
                  sales.saleItems[index].price,
                  "Shoprite",
                  "50% off",
                  sales.saleItems[index].imageUrl,
                ),
              ],
            ),
          ),
        ),

        // Second section with Categories
        SizedBox(
          height: mediaQuery.size.height * 0.01,
        ),
        //Row that holds title and see all
        HomeColumnHeaderWidget("Categories", "See all"),
        SizedBox(
          height: mediaQuery.size.height * 0.01,
        ),

        // Container that holds the sliding categories
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height * 0.2,
          //color: Colors.white,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: DUMMY_CATEGORIES.length,
            itemBuilder: (ctx, i) => Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(DUMMY_CATEGORIES[i].imageName,
                              width: 100, height: 100, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.01,
                      ),
                      Text(
                        DUMMY_CATEGORIES[i].title,
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.02,
                ),
              ],
            ),
          ),
        ),

        // Third section with shops
        SizedBox(height: mediaQuery.size.height * 0.01),
        //Row that holds title and see all
        HomeColumnHeaderWidget("Shops", "See all"),
        SizedBox(height: mediaQuery.size.height * 0.01),

        //Container that holds the sliding Shops
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height * 0.2,
          //color: Colors.white,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: SHOPSLIST.length,
            itemBuilder: (ctx, i) => Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(SHOPSLIST[i].imageName,
                              width: 100, height: 100, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.01,
                      ),
                      Text(
                        SHOPSLIST[i].title,
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.02,
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
