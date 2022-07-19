import 'package:ecommerce_app/views/screens/widget/all_products.dart';
import 'package:ecommerce_app/views/screens/widget/category.dart';
import 'package:ecommerce_app/views/screens/widget/category_list.dart';
import 'package:ecommerce_app/views/screens/widget/customApp_bar.dart';
import 'package:ecommerce_app/views/screens/widget/products.dart';
import 'package:ecommerce_app/views/screens/widget/search_input.dart';
import 'package:ecommerce_app/views/screens/widget/tagList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/clothes_model.dart';
import 'package:provider/provider.dart';
import '../../provider/order_provider.dart';
import '../../provider/products_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<Products>(context);
    _productsProvider.fetchProducts();
    final orderProvider = Provider.of<Orders>(context);
    orderProvider.fetchOrders();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            SearchInput(),
            TagList(),
            Category(),
            CategoryList(),
            AllProducts(),
          ],

        ),
      ),
    );
  }
}
