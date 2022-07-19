import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/views/screens/widget/cart_empty.dart';
import 'package:ecommerce_app/views/screens/widget/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    final _cartProvider = Provider.of<CartProvider>(context);
    return _cartProvider.getCartItem.isNotEmpty? Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white70,
        title: Center(
          child: Text(
            "Cart (${_cartProvider.getCartItem.length})",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.clearCartData();
            },
            icon: Icon(
              CupertinoIcons.trash,
              color: Colors.red,
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                //firebase orders collectionu oluştur içine verileri ekle
                onPressed: () async{
                  _cartProvider.getCartItem
                      .forEach((key, orderValue) async{
                       //unique orderId oluşturma
                       final orderId = uuid.v4();
                       await firebaseStore
                        .collection('orders')
                        .doc(orderId)
                        .set({
                         "orderId": orderId,
                         "userId": firebaseAuth.currentUser!.uid,
                         "title": orderValue.title,
                         "price": orderValue.price,
                         "imageUrl": orderValue.imageUrl,
                         "quantity": orderValue.quantity,
                         "orderDate": Timestamp.now(),
                         }
                    );
                  });
                },
                  child: Text(
                    "Checkout",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,

                    ),
                  ),
              ),
            ),
            Spacer(),
            Text(
              'Total',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5,),
            Text(
              '\$${_cartProvider.totalAmount?.toStringAsFixed(3)}',
              style: TextStyle(
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: _cartProvider.getCartItem.length,
          itemBuilder: (BuildContext context, int index) {
            return ChangeNotifierProvider.value(
              value: _cartProvider.getCartItem.values.toList()[index],
              child: CartItem(
                //item sayma
                productId: _cartProvider.getCartItem.keys.toList()[index],
              ),
            );
       }
      ),
    ):Scaffold(
      body: CartEmpty(),
    );
  }
}
