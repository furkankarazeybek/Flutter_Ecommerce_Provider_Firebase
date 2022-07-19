import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/clothes_model.dart';
import 'package:ecommerce_app/views/screens/widget/products.dart';
import 'package:provider/provider.dart';
import '../../../models/products_model.dart';
import '../../../provider/products_provider.dart';

class AllProducts extends StatelessWidget {
  final clothesList = Clothes.generateClothes();

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<Products>(context);

    List<Product> _productList= _productsProvider.products;
    return Container(
      child: Column(
        children: [
          Container(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,  //liste yan
                itemBuilder: (context,index)=>ChangeNotifierProvider.value(
                  value: _productList[index],
                  child: ProductItem(
                    index: index,),
                ),
                separatorBuilder: ( _, index)=>SizedBox(width: 8,),
                itemCount: _productList.length)

          ),
        ],
      ),
    );
  }
}


