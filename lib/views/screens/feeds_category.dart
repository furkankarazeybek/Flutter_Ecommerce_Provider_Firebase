import 'package:ecommerce_app/views/screens/widget/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/products_model.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/products_provider.dart';




class FeedsCategoryScreen extends StatelessWidget {
  static const String id = 'feedsCategoryScreen';



  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    print(categoryName);
    final productList = productsProvider.findByCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,  //appbar çizgisi 0 kalınlık
        backgroundColor: Colors.white,
        title: Text('Feeds Products',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        childAspectRatio: 240/320, //en boy oranı verme
        children: List.generate(
          productList.length,
              (index) => ChangeNotifierProvider.value(
            value: productList[index],
            child: FeedsProducts(),
          ),
        ),
      ),
    );
  }
}
