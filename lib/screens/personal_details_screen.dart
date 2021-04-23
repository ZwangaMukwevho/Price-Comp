import 'package:flutter/material.dart';

import 'package:shop_app/widgets/personal_details_list.dart';

class PersonalDetailsScreen extends StatelessWidget {
  static const routeName = '/person-details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
     
      body: PersonalDetailsList(),
    );
  }
}
