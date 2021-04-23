import 'package:flutter/material.dart';

import '../widgets/comp_split_view.dart';
import '../widgets/app_drawer.dart';

class ComparisonScreen extends StatelessWidget {
  // Route for comparisonScreen page
  static const routeName = '/Comparison-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compare prices"),
      ),
      drawer: AppDrawer(),
      body: CompSplitView(),

      // // Action button used to select shop
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: null,
      //   child: Icon(Icons.add),
      // ),

      
    );
  }
}
