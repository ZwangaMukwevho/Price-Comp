import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/splash_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './screens/categories_screen.dart';
import './screens/shops_screen.dart';
import './screens/comparison_screen.dart';
import './providers/comp_item.dart';
import 'screens/search_product_screen.dart';
import 'providers/searchWord.dart';
import 'screens/bottom_tab_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/home_screen.dart';
import 'providers/sale.dart';
import './providers/users.dart';
import './screens/personal_details_screen.dart';
import './providers/scrap_products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Users>(
            update: (ctx, auth, _) => Users(auth.token, auth.userId),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, ScrapProducts>(
            update: (ctx, auth, previousProducts) => ScrapProducts(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items,
            ),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, SearchWord>(
            update: (ctx, auth, _) => SearchWord(auth.token, auth.userId),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Sale>(
            update: (ctx, auth, _) => Sale(auth.token, auth.userId),
          ),

          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
              auth.token,
              auth.userId,
              previousOrders == null ? [] : previousOrders.orders,
            ),
          ),
          ChangeNotifierProvider.value(
            value: Comp(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.redAccent,
                fontFamily: 'Lato',
              ),

              // If the user has logged in the home page is changed from being the auth_screen
              home: auth.isAuth
                  ? BottomTabScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
                ShopsScreen.routeName: (ctx) => ShopsScreen(),
                ComparisonScreen.routeName: (ctx) => ComparisonScreen(),
                ProductsOverviewScreen.routeName: (ctx) =>
                    ProductsOverviewScreen(),
                SeacrchProduct.routeName: (ctx) => SeacrchProduct(),
                ProfileScreen.routeName: (ctx) => ProfileScreen(),
                BottomTabScreen.routeName: (ctx) => BottomTabScreen(),
                HomeScreen.routeName: (ctx) => HomeScreen(),
                PersonalDetailsScreen.routeName: (ctx) =>
                    PersonalDetailsScreen(),
              }),
        ));
  }
}
