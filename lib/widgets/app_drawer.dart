import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';

import '../screens/orders_screen.dart';
import '../providers/auth.dart';
import '../screens/shops_screen.dart';
import '../screens/comparison_screen.dart';
import '../screens/profile_screen.dart';
import '../providers/users.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userProv = Provider.of<Users>(context, listen: false);
  
    return Drawer(
      child: Column(
        children: <Widget>[
          // AppBar(
          //   title: Text('Hello Friend!'),
          //   automaticallyImplyLeading: false,
          // ),
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            accountName: Padding(
              padding: EdgeInsets.only(top: 2),
              child: Row(
                children: <Widget>[
                  Text(
                  //userProv.user.name,
                  'Zwanga',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // User newUser = new User(
                      //   name: "Zwanga",
                      //   surname: "Mukwevho",
                      //   email: "zwangatm3@gmail.com",
                      //   phoneNumber: "0761256040",
                      //   dateOfBirth: "01/02/2000",
                      //   //userId: "",
                      // );
                      // final userProv = Provider.of<Users>(context, listen: false);
                      // userProv.addUser(newUser);
                    },
                  ),
                ],
              ),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue,
                )),
            accountEmail: null,
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            dense: true,
          ),

          // Shops option
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shops'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ShopsScreen.routeName);
            },
            dense: true,
          ),

          // Categories option
          Divider(),
          ListTile(
            leading: Icon(Icons.compare),
            title: Text('Compare shops'),
            onTap: () {
              Navigator.of(context).pushNamed(ComparisonScreen.routeName);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            dense: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
            dense: true,
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text('Manage Products'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(BottomTabScreen.routeName);
          //   },
          //   dense:true,
          // ),

          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routeName);
            },
            dense: true,
          ),

          // Creating Icon for logging out
          Spacer(),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
            dense: true,
          )
        ],
      ),
    );
  }
}
