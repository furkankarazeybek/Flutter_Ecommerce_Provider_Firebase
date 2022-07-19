import 'dart:io';

import 'package:ecommerce_app/const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';


class UploadProductController {
  _uploadImageToStorage(File? imageUrl)async {
    final productId = uuid.v4();
    Reference ref= firebaseStorage
        .ref()
    //firebase storage products'a kaydeder
        .child("products")
        .child(productId);
    UploadTask uploadTask = ref.putFile(imageUrl!);
    TaskSnapshot snap= await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;

  }

  var uuid = Uuid();
  Future<String?>uploadProducts(
      String id,
      String title,
      String price,
      String productCategoryName,
      String description,
      String quantity,
      File? imageUrl) async{
        String res= "Something happened";

        try{
          //productId için eşşiz bir değer oluşturur
          final productId = uuid.v4();
          if(

              title.isNotEmpty &&
              price.isNotEmpty &&
              productCategoryName.isNotEmpty &&
              description.isNotEmpty &&
              quantity.isNotEmpty &&
              imageUrl!=null
          ) {
            String downloadUrl = await _uploadImageToStorage(imageUrl);

            await firebaseStore.collection('products').doc(productId).set({
              'id': id,
              'title': title,
              'price': price,
              'productCategoryName': productCategoryName,
              'description' : description,
              'quantity' : quantity,
              'imageUrl' : downloadUrl,

            });
          }
        }
        catch(e){
        }
        return res;
  }
}