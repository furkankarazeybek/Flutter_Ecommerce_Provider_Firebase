import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class OrderAttr with ChangeNotifier {
  final String orderId;
  final String userId;
  final String? productId;
  final String title;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;

  OrderAttr({
    required this.orderId,
    required this.userId,
     this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.orderDate,
      }
    );
}