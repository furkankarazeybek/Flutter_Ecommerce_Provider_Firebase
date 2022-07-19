
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String productCategoryName;
  final int quantity;

  Product({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.imageUrl,
        required this.productCategoryName,
        required this.quantity});



}