import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cart_attr_model.dart';
import '../detail/detail_page.dart';


class CartItem extends StatelessWidget {
  final String productId;

  const CartItem({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final _cartAttr = Provider.of<CartAttr>(context);
    final _cartProvider = Provider.of<CartProvider>(context);



    double subtotal = _cartAttr.price * _cartAttr.quantity;
    
    return GestureDetector(
      onTap: (){
        //item sayma
        Navigator.pushNamed(context,DetailPage.id, arguments: productId);
      },
      child: Container(
        margin: EdgeInsets.all(10,),
        height: 180,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(10),
          color: Colors.white70,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        '${_cartAttr.imageUrl}',
                    ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Flexible(
              child: Column(
                children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_cartAttr.title}',
                          style: TextStyle(
                              fontSize:16,
                              fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _cartProvider.removeCartItem(productId);
                        },
                        icon: Icon(
                            CupertinoIcons.delete_left,
                            color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                   Text(
                     'Price',
                     style: TextStyle(fontSize: 16,
                     fontWeight: FontWeight.w500),
                   ),
                  SizedBox(width: 10,),
                  Text(
                    '${_cartAttr.price}\$',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                   ),
                  ],
                 ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'subtotal:',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      '\$${subtotal}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text(
                        'Ship Fee',
                        style: TextStyle(
                            fontSize:16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      IconButton(onPressed: () {
                        _cartProvider.reduceCartItem(productId,
                        _cartAttr.price,
                        _cartAttr.title,
                        _cartAttr.imageUrl
                        );
                      },
                        icon: Icon(
                            CupertinoIcons.minus_rectangle,
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                          ),
                          child: Center(
                              child: Text(
                                '${_cartAttr.quantity}',
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {
                        _cartProvider.addProductToCart(productId, _cartAttr.price, _cartAttr.title, _cartAttr.imageUrl);
                      },
                          icon: Icon(
                              CupertinoIcons.add),
                      ),
                    ],
                  ),
               ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
