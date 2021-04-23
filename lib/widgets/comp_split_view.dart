import 'package:flutter/material.dart';
import 'package:shop_app/widgets/column_widget.dart';
import 'package:provider/provider.dart';

import '../providers/comp_item.dart';
import '../screens/search_product_screen.dart';

class CompSplitView extends StatefulWidget {
  @override
  _CompSplitViewState createState() => _CompSplitViewState();
}

class _CompSplitViewState extends State<CompSplitView> {
  // Container that'll hold an individual product
  Widget productTile(
          String name, String price, String promo, String imageUrl) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          //borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 80,
              width: 50,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      promo,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      price,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              height: 80,
              width: 100,
            )
          ],
        ),
      );

  // Alternative widget to hold the product
  Widget productTile1(
          String name, String price, String promo, String imageUrl) =>
           Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                // Elevation adds shodow behign the card
                elevation: 8,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            imageUrl,
                            height: 70,
                            // width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              // style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            //alignment: Alignment.centerLeft,
                            child: Text(
                              promo,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          //SizedBox(width: 10),
                          Align(
                            //alignment: Alignment.bottomLeft,
                            child: Text(
                              price,
                              overflow: TextOverflow.ellipsis,
                              //style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );

  Widget addButton(int columnNo) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(columnNo));
            },
            icon: Icon(Icons.add_circle),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // Media query variable
    final mediaQuery = MediaQuery.of(context);
    final compItem = Provider.of<Comp>(context);
    final itemList1 = compItem.compItems1;
    final itemList2 = compItem.compItems2;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        // Will include individual columns as children that will hold products
        children: [
          // Left hand side of split view
          Column(
            children: <Widget>[
              // Container that will hold the shop name
              ColumnWidget(1),

              // Container that'll hold an individual product
              Expanded(
                child: Container(
                  height: 150,
                  width: 150,
                  child: ListView.builder(
                    itemCount: itemList1.length,
                    itemBuilder: (ctx, i) => Row(
                      children: [
                        Flexible(
                          flex: 9,
                          child: productTile1(
                            itemList1[i].title,
                            'No promo',
                            'R${itemList1[i].price}',
                            itemList1[i].imageUrl,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              compItem.deleteCompItem(itemList1[i].title, 1);
                              compItem.listTotal(1);
                             
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Row(children: [,
              //     productTile1("1","2","3","https://th.bing.com/th/id/OIP.x_SLZzY-RRjkKVSLaoUmBAHaE8?w=272&h=181&c=7&o=5&pid=1.7"),
              //     Icon(Icons.delete),

              // ],),

              addButton(1),

              Container(
                width: mediaQuery.size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "TOTAL:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "R${compItem.priceTotal1.toStringAsFixed(2)}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Right hand side of split view
          Column(children: [
            // Container that will hold the shop name
            ColumnWidget(2),

            // Container that'll hold an individual product
            Expanded(
                child: Container(
                  height: 150,
                  width: 150,
                  child: ListView.builder(
                    itemCount: itemList2.length,
                    itemBuilder: (ctx, i) => Row(
                      children: [
                        Flexible(
                          flex: 9,
                          child: productTile1(
                            itemList2[i].title,
                            'No promo',
                            'R${itemList2[i].price}',
                            itemList2[i].imageUrl,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              //print(itemList2.length.toString(),);
                              compItem.deleteCompItem(itemList2[i].title, 2);
                              compItem.listTotal(2);
                             
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Add button that allows user to add a product tile
            addButton(2),
            Container(
              width: mediaQuery.size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "TOTAL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "R${compItem.priceTotal2.toStringAsFixed(2)}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  } 
}
