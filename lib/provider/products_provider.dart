import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const.dart';
import 'package:flutter/cupertino.dart';
import '../models/products_model.dart';

class Products with ChangeNotifier{

  List<Product> _products = [];
  
  //database products collections'dan veriler get
  Future<void>fetchProducts() async{
    await firebaseStore.collection('products')
        .get()
        .then((QuerySnapshot productSnapShot) {
      _products = [];
      productSnapShot.docs.forEach((element) { 
        _products.insert(0,
          Product(
            id: element.get('id'),
            title: element.get('title'),
            description: element.get('description'),
            price: double.parse(element.get('price')),
            imageUrl: element.get('imageUrl'),
            productCategoryName: element.get('productCategoryName'),
            quantity: int.parse(element.get('quantity')),
         )
        );
      });
    });
  }
 //product id'yi almak için fonksiyon, cart bağlantısı için
  Product findById(String productId) {
    return _products.firstWhere((element) => element.id==productId);
  }

  List<Product> get products{
    return _products;
  }

  //categorileri almak için
  List<Product> findByCategory(String categoryName) {
   List _categoryList = _products.where((element) =>
       element.productCategoryName.toLowerCase().contains(categoryName.toLowerCase())).toList();

   return [..._categoryList];
  }


  List<Product>? searchQuery(String searchText) {
    List _searchList = _products
        .where((element)=>
        element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return [..._searchList];

  }
}