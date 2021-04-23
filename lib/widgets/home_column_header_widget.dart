import 'package:flutter/material.dart';

class HomeColumnHeaderWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  HomeColumnHeaderWidget(this.title, this.subTitle);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
          width: mediaQuery.size.width * 0.9,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: mediaQuery.size.width * 0.5,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  subTitle,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        );
  }
}