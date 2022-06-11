import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/scrap_products.dart';
import 'package:shop_app/providers/users.dart';

import '../widgets/app_drawer.dart';
import '../providers/products.dart';
import '../providers/searchWord.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/home_column.dart';
import '../providers/sale.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/Home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Fetch the products from firebase when the product overview screen is loaded
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Runs on initial state only
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(Duration(milliseconds: 700)).then((_) async {
        final userProv = Provider.of<Users>(context, listen: false);
        userProv.fetchAndSetUsers();
        Provider.of<Sale>(context, listen: false).fetchAndSetSales();
        Provider.of<SearchWord>(context, listen: false).fetchAndSetWords();
        await Provider.of<Products>(context, listen: false)
            .fetchAndSetProducts()
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
        await Provider.of<ScrapProducts>(context, listen: false)
            .fetchAndSetProducts("picknpay")
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: HomeSearch(),
                );
              },
              icon: Icon(Icons.search)),
        ],
        //title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : HomeColumn(),
    );
  }
}

class HomeSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text("SelectedResult"),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //throw UnimplementedError();
    final products = Provider.of<Products>(context);
    final searchWords = Provider.of<SearchWord>(context);

    List<String> myList = [];
    myList = searchWords.searchList;

    // Iterating through the list of products and creating a list of product titles
    List<String> prodList = [];
    products.items.forEach(
      (prod) {
        prodList.add(prod.title.toLowerCase());
      },
    );

    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = myList
        : suggestionList.addAll(
            prodList.where(
              (element) => element.contains(query.toLowerCase()),
            ),
          );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        Product matchedProduct = products.items.firstWhere(
            (prod) => prod.title.toLowerCase() == suggestionList[index]);

        return ListTile(
          leading: CircleAvatar(
            child: Image.network(matchedProduct.imageUrl),
          ),
          title: Text(
            suggestionList[index],
          ),
          onTap: () {
            String selectedResult = suggestionList[index];
            searchWords.addWord(selectedResult);

            showResults(context);
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: matchedProduct.id,
            );
          },
        );
      },
    );
  }
}
