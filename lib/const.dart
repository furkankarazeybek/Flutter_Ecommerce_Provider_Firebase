import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/views/screens/card_screen.dart';
import 'package:ecommerce_app/views/screens/feeds_screen.dart';
import 'package:ecommerce_app/views/screens/home_screen.dart';
import 'package:ecommerce_app/views/screens/profile_screen.dart';
import 'package:ecommerce_app/views/screens/search_screen.dart';
import 'package:ecommerce_app/views/screens/uplod_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_app/views/screens/auth/sign_up_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';


var backgroundColor = Colors.black;

var buttonColor = Colors.black;

var textButton = Colors.white;


class TextKutulari extends StatelessWidget {
  const TextKutulari({Key? key, required this.hinttext,this.kontrolcu,this.keyboard}) : super(key: key);
  final String hinttext;
  final  keyboard;
  final kontrolcu;

@override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboard,
      controller: kontrolcu,
      decoration: InputDecoration(
        hintText: hinttext,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.black)),
      ),
    );
  }
}


class Buttons extends StatelessWidget {


  const Buttons({Key? key, required this.text, this.kontrolcu1, this.kontrolcu2, this.kontrolcu3,
  this.kontrolcu4, this.controllerType}) : super(key: key);
  final String text;
  final  kontrolcu1;
  final  kontrolcu2;
  final  kontrolcu3;
  final  kontrolcu4;
  final  controllerType;



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width -40,
      height: 50,
      decoration: BoxDecoration(
        color: buttonColor,

      ),
      child: Center(
        child: InkWell(
          onTap:() async{
            await controllerType.signUpUsers(
              kontrolcu1,
              kontrolcu2,
              kontrolcu3,
              kontrolcu4,
            );
          },
          child: Text(
            text,
            style: TextStyle(
              color: textButton,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

//FIREBASE

var firebaseAuth = FirebaseAuth.instance;  //firebase giriş kayıt

var firebaseStore = FirebaseFirestore.instance; //firestore database kayıt edilmesi

var firebaseStorage = FirebaseStorage.instance;

//Pages

List pages = [
  HomeScreen(),
  FeedsScreen(),
  SearchScreen(),
  CardScreen(),
  UploadProductForm(),
  ProfileScreen(),
];