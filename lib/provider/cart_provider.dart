
import 'package:ecommerce_app/models/cart_attr_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';


class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItem {
    return {..._cartItems};
  }

  //toplam ücret
  double? get totalAmount{
    var total = 0.0;

    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;

    });

    return total;
  }



  //sepete ürün ekleme
  void addProductToCart(String productId,double price,String title,String imageUrl) {
   if(_cartItems.containsKey(productId)) {
     _cartItems.update(productId, (existingCartItem) => CartAttr(
       id: existingCartItem.id,
       title: existingCartItem.title,
       price: existingCartItem.price,
       quantity: existingCartItem.quantity+1,
       imageUrl: existingCartItem.imageUrl,
      ),
     );
   }
   else{
     _cartItems.putIfAbsent(productId, () => CartAttr(
       id: DateTime.now().toString(),
       title: title,
       price: price,
       quantity: 1,
       imageUrl: imageUrl,
      ),
     );
   }
   notifyListeners();
  }
  //sepet ürün azaltma
  void reduceCartItem(String productId, double price, String title, String imageUrl) {
    if(_cartItems.containsKey(productId)) {
      _cartItems.update(productId,(existingCartItem) {
        return CartAttr(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity-1,
            imageUrl: existingCartItem.imageUrl);
       });
    }
    notifyListeners();
  }

  //sepetten ürün silme
  void removeCartItem(productId) {
    _cartItems.remove(productId);

    notifyListeners();
  }

  //sepetteki tüm ürünleri silme
  void clearCartData() {
    _cartItems.clear();

    notifyListeners();
  }
}