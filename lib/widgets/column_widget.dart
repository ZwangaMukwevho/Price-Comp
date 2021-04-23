import 'package:flutter/material.dart';

import '../models/categories.dart';

class ColumnWidget extends StatefulWidget {
  final int columnNo;
  ColumnWidget(this.columnNo);

  // Function that has BottomSheet
  @override
  _ColumnWidgetState createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  List shopList = SHOPSLIST.map((num) => num).toList();
  

  void selectShop(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          child: ListView.separated(
            itemCount: shopList.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  _shopNumber(index);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      shopList[index].imageName,
                    ),
                  ),
                  title: Text(shopList[index].title),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        );
      },
    );
  }

  void _shopNumber(int num) {
    setState(() {
      if (widget.columnNo == 1) {
        fieldName1 = shopList[num].title;
        shopColor1 = shopList[num].color;
      } else if (widget.columnNo == 2) {
        fieldName2 = shopList[num].title;
        shopColor2 = shopList[num].color;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Media query variable
    final mediaQuery = MediaQuery.of(context);

     if(widget.columnNo==1){
       fieldName = fieldName1;
       shopColor = shopColor1;
        }
      else if(widget.columnNo==2){
        fieldName = fieldName2;
        shopColor = shopColor2;
      }
    return GestureDetector(
      
      onTap: () {
        selectShop(context);
       
      },
      child: Container(
        
        decoration: BoxDecoration(
          color: shopColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.symmetric(vertical: 20),
        height: mediaQuery.size.width * 0.1,
        width: mediaQuery.size.width * 0.3,

        child: Align(
          alignment: Alignment.center,
          child: Text(   
            fieldName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

       
      ),
    );
  }
}
