import 'package:flutter/material.dart';
import 'package:shop_app/screens/personal_details_screen.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    List<String> profileContents = [
      "Product Alerts",
      "Personal information",
      "Help",
      "Settings"
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
          trailing: Icon(Icons.arrow_forward_ios),
           onTap: (){
            if(i == 1){
              Navigator.of(context).pushNamed(
              PersonalDetailsScreen.routeName,
            );
            }
          },
        ),
      ),
    );
  }
}
