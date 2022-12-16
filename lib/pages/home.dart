import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/pages/products_page.dart';
import 'package:major_kill_minis/persistence/database.dart';
import 'package:major_kill_minis/widgets/custom_navigation_drawer.dart';
import 'package:major_kill_minis/widgets/custom_search_delegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search)
          )
        ],
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: backgroundColor,
      body: ProductsPage(products: PersistentDatabase.getProducts()),
    );
  }
}
