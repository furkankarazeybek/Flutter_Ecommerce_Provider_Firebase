import 'package:ecommerce_app/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/products_provider.dart';

class BottomNavBar extends StatefulWidget {

   BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex= 0;

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<Products>(context);
    _productsProvider.fetchProducts();
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        activeColor: Colors.blue,
        inactiveColor: Colors.white,
        backgroundColor:Colors.black,items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label:"Home" ),
        BottomNavigationBarItem(icon: Icon(Icons.rss_feed, size: 30), label:"Feeds" ),
        BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label:"Search" ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag, size: 30), label:"Cart" ),
        BottomNavigationBarItem(icon: Icon(Icons.upload, size: 30), label:"Upload" ),
        BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label:"Person" ),
       ],
      ),
      body: pages[pageIndex],
    );
  }
}






// Icons.home
// Icons.rss_feed
// Icons.search
// Icons.shopping_bag
// Icons.person
// CupertinoIcons.upload_circile_fill,