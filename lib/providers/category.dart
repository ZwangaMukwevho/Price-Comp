import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  final String imageName;

  const Category({
    @required this.id,
    @required this.title,
    @required this.imageName,
    this.color = Colors.orange,
  });
}
