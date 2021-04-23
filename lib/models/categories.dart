import 'package:flutter/material.dart';

import '../providers/category.dart';
import '../providers/shop.dart';


const DUMMY_CATEGORIES = const [
  Category(
    id: 'c1',
    title: 'Fresh Food',
    color: Colors.purple,
    imageName:"Assets/images/freshFood.jpg",
  ),
  Category(
    id: 'c2',
    title: 'Pantry',
    color: Colors.red,
    imageName:"Assets/images/pantry.jpg",
  ),
  Category(
    id: 'c3',
    title: 'Frozen food',
    color: Colors.orange,
    imageName:"Assets/images/frozenFood.jpg",
  ),
  Category(
    id: 'c4',
    title: 'Beverages',
    color: Colors.amber,
    imageName:"Assets/images/beverages.jpg",
  ),
  Category(
    id: 'c5',
    title: 'Health and Beauty',
    color: Colors.blue,
    imageName:"Assets/images/healthAndBeauty.png",
  ),
  Category(
    id: 'c6',
    title: 'Kids',
    color: Colors.green,
    imageName:"Assets/images/kids.jfif",
  ),
  Category(
    id: 'c7',
    title: 'Household cleaning',
    color: Colors.lightBlue,
    imageName:"Assets/images/householdCleaning.jpg",
  ),
  Category(
    id: 'c8',
    title: 'Home and Outdoor',
    color: Colors.brown,
    imageName:"Assets/images/homeAndOutdoor.jpg",
  ),
   Category(
    id: 'c9',
    title: 'Convinience meals',
    color: Colors.pink,
   imageName:"Assets/images/convinienceMeals.jpg",
  ),
   Category(
    id: 'c10',
    title: 'Electronics and Office',
    color: Colors.black,
    imageName:"Assets/images/electronicsAndOffice.jpg",
  ),
  Category(
    id: 'c11',
    title: 'Pets',
    color: Colors.yellow,
    imageName:"Assets/images/pets.jpg",
  ),
   Category(
    id: 'c12',
    title: 'Wine and Liquor',
    color: Colors.deepOrange,
   imageName:"Assets/images/wineAndLiquor.jpg",
  ),
  
];


const SHOPSLIST = const [
  Shop(
    id: 'c1',
    title: 'Shoprite',
    color: Colors.red,
    imageName:"Assets/images/Shoprite.png",
  ),
  Shop(
    id: 'c2',
    title: 'Pick n Pay',
    color: Colors.blue,
    imageName:"Assets/images/pick-n-pay.jpg",
  ),
  Shop(
    id: 'c3',
    title: 'Checkers',
    color: Colors.blue,
    imageName: "Assets/images/Checkers.jpg",
  ),
  Shop(
    id: 'c4',
    title: 'Woolworths',
    color: Colors.black,
    imageName: "Assets/images/Woolworths.jpg",
  ),
  Shop(
    id: 'c5',
    title: 'Spar',
    color: Colors.green,
    imageName: "Assets/images/Spar.jpg",
  ),
  Shop(
    id: 'c6',
    title: 'Game',
    color: Colors.pink,
    imageName: "Assets/images/Game.jpg",
  ),
  Shop(
    id: 'c7',
    title: 'Makro',
    color: Colors.black,
    imageName: "Assets/images/Makro.png",
  ),
  Shop(
    id: 'c8',
    title: 'Clicks',
    color: Colors.green,
    imageName: "Assets/images/clicks.png",
  ),
   Shop(
    id: 'c9',
    title: 'Dischem',
    color: Colors.green,
    imageName: "Assets/images/Dischem.png",
  ),
  
  
];

var fieldName = "Select shop";
Color shopColor = Colors.black;
var fieldName1 = "Select shop";
Color shopColor1 = Colors.black;
var fieldName2 = "Select shop";
Color shopColor2 = Colors.black;