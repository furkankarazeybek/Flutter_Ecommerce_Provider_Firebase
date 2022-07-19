import 'package:ecommerce_app/views/screens/auth/forgot_password_screen.dart';
import 'package:ecommerce_app/views/screens/auth/sign_up_screen.dart';
import 'package:ecommerce_app/views/screens/bottom_navbar.dart';

import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import "package:ecommerce_app/const.dart";


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController= TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  //giriş konrol, snackbar
  loginUsers() async{
    setState(() {
      _isLoading = true;
    });
    String res= await AuthController().loginUsers(
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading= false;
    });
    if(res != "success"){
      return showSnackBar(res, context);
    } else {
      
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomNavBar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextKutulari(hinttext: "Email Giriniz", kontrolcu: _emailController),
            SizedBox(height:20),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Şifre Giriniz",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
               ),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.black)),
            ),
          ),

            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width -40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    loginUsers();
                    _emailController.clear();
                    _passwordController.clear();
                  },
                  child: _isLoading ? Center(child: CircularProgressIndicator(color:Colors.white),) :
                  Text(
                    "Giriş",
                    style: TextStyle(
                      color: textButton,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hesabın yok mu?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  SignUpScreen()));

                  },
                  child: Text('Hesap Oluştur',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
            SizedBox(height: 10),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                },
                child: Text("Şifremi unuttum",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:15),)),

          ],
        ),
      ),
    );
  }
}



