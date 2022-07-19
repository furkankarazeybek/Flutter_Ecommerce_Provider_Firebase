import 'package:flutter/material.dart';
import 'package:ecommerce_app/views/screens/widget/category_item.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context,int index)=>CategoryItem(
              index: index),
      ),
    );
  }
}
