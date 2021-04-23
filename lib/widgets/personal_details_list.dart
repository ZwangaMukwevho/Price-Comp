import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/users.dart';

import '../screens/product_detail_screen.dart';

class PersonalDetailsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<Users>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    List<String> profileContents = [
      "Name",
      "Surname",
      "Email",
      "Password",
      "Phone Number",
      "Date of Birth"
    ];

    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black38,
          height: 5,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        itemCount: profileContents.length,
        itemBuilder: (ctx, i) => ListTile(
          
          
          title: Text(profileContents[i]),
          subtitle: Text(
            userProv.userList[0].name,
            style: TextStyle(
            fontSize: 15,
            color: Colors.blue),
          ),
          trailing: Icon(Icons.edit),
        ),
      ),
    );
  }
}
