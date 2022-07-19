import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:ecommerce_app/const.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:camera/camera.dart';
import 'package:cross_file/cross_file.dart';





class AuthController {
   //database image kaydetme

  _uploadImageToStorage(Uint8List? image)async {
    Reference ref= firebaseStorage
        .ref()
        .child("profilePic")
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
       TaskSnapshot snap= await uploadTask;
       String downloadUrl = await snap.ref.getDownloadURL();
       return downloadUrl;

  }


  //image pick etmek için kontrol, galeriden

  pickImage(ImageSource source) async{
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file= await _imagePicker.pickImage(source: source);
    if(_file !=null) {
      return await _file.readAsBytes();
    } else{
      print('Resim Seçilmedi');
    }
  }




  //hesap oluşturmak için kontrol
  Future<String>signUpUsers(String full_name, String username, String email,String phoneNumber, String password, Uint8List? image)async{
    String res= "Bir hata meydana geldi";

    try{
      if(full_name.isNotEmpty &&
          username.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty&&
          image != null
      ) {
        UserCredential cred =await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        String downloadUrl = await _uploadImageToStorage(image);

            await firebaseStore.collection("users").doc(cred.user!.uid).set({   //firestoreveritabanı
              "fullName":full_name,
              "username": username,
              "email": email,
              "phoneNumber": phoneNumber,
              "image": downloadUrl,
            });

        print(cred.user!.email);
        res = 'success';
      }
      else{
        res= "Please fields must not be empty";
      }
    }

    catch (e){
      res= e.toString();
    }
    return res;
  }


  //giriş için kontrol
   loginUsers(String email,String password) async{
    String res= "Bir hata meydana geldi";


      try {
        if(email.isNotEmpty && password.isNotEmpty) {
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          res= "success";
          print("Giriş yaptınız");
        } else{
          res = "Alanlar boş olamaz";
        }

      } catch(e) {
        res = e.toString();
      }
      return res;
   }

   forgotPassword(String email) async{
    String res = "Some error occured";

    try{
      if(email.isNotEmpty) {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        res = "success";
        print("şifre sıfırlama bağlantısı email adresinize gönderildi");
      } else {
        res =  "Email alanı boş olamaz";
      }
    }
    catch(e){
      res = e.toString();
    }
    return res;
   }
}




showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}























