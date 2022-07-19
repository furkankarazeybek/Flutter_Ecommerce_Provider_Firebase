import 'package:ecommerce_app/views/screens/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/order_provider.dart';

class OrderScreen extends StatelessWidget {
  static const String id = 'orderScreen';
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context);
    return Scaffold(
      body : FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapShot) {
          return ListView.builder(
            itemCount: orderProvider.getOrders.length,
            itemBuilder: (BuildContext context, int index) {
              return ChangeNotifierProvider.value(
                  value: orderProvider.getOrders[index],
                  child: OrderItem());
            },
          );
         }
        ),
    );
  }
}
