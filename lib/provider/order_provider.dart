
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../models/order_attr.dart';

class Orders with ChangeNotifier {

  List<OrderAttr> _orders = [];

  List<OrderAttr> get getOrders {
    return _orders;
  }


  //database orders collections'dan veriler get
  Future<void> fetchOrders() async {
    await firebaseStore
        .collection('orders').where('userId', isEqualTo: firebaseAuth.currentUser!.uid)
        .get()
        .then((QuerySnapshot orderSnapShot) {
      _orders = [];
      orderSnapShot.docs.forEach((element) {
        //orders içerisine get
        _orders.insert(0,
          OrderAttr(orderId: element.get('orderId'),
              userId: element.get('userId'),
              title: element.get('title'),
              price: element.get('price').toString(),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              orderDate: element.get('orderDate')
          ),
        );
      }
      );
    });
    notifyListeners();
  }
}