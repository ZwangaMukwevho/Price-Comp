import 'package:flutter/material.dart';

class Shop {
  final String id;
  final String title;
  final String imageName;
  final Color color;
  

  const Shop({
    @required this.id,
    @required this.title,
    @required this.imageName,
    this.color = Colors.orange,
    
  });
}
