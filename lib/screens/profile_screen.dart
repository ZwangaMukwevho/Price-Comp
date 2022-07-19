import 'package:flutter/material.dart';

import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/profileBody.dart';
import '../widgets/product_details.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      drawer: AppDrawer(),
      body: ProfileBody(),
    );
  }
}
