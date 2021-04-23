import 'package:flutter/material.dart';
  
import 'cart_screen.dart';
import 'comparison_screen.dart';
import 'profile_screen.dart';
import '../widgets/app_drawer.dart';
import '../screens/home_screen.dart';

class BottomTabScreen extends StatefulWidget {
  static const routeName = '/BottomTabScreen';
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  // List of pages that will be used on the bottom AppBar on the home screen
  final List<Widget> _pages = [
    
    CartScreen(),
    ComparisonScreen(),
    ProfileScreen()
  ];

  // Indicates the page number that was selected by a user
  //int _selectedPageIndex = 0;

  // Functions that handles the switching of pages
  // void _selectedPage(int index){
  //   setState(() {
  //   _selectedPageIndex = index;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      
      child: Scaffold(
        
        drawer: AppDrawer(),
        body: TabBarView(
          // Disables the horizontal shifting
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomeScreen(),
            CartScreen(),
            ComparisonScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          
          height: 60,
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home'
              ),
              Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Cart',
              ),
              Tab(
                icon: Icon(Icons.compare),
                text: 'Comparisons',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
            ],
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(1),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('meals'),
    //   ),
    //   drawer: AppDrawer(),
    //   body: _pages[0],
    //   bottomNavigationBar: BottomNavigationBar(
    //     //onTap: _selectedPage,
    //     backgroundColor: Colors.orange,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         title: Text('home'),
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.outlined_flag),
    //         title: Text('Compare shops'),
    //       ),
    //        BottomNavigationBarItem(
    //         icon: Icon(Icons.shopping_cart),
    //         title: Text('Cart'),
    //       ),
    //        BottomNavigationBarItem(
    //         icon: Icon(Icons.person),
    //         title: Text('Profile'),
    //       ),
    //     ]
    //   ),
    // );
  }
}
