import 'dart:ffi';
import 'dart:typed_data';

import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import "package:ecommerce_app/const.dart";
import 'package:image_picker/image_picker.dart';


class SignUpScreen extends StatefulWidget {
    SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();


  Uint8List? _image;
  bool _isLoading = false;

  selectImage() async{
    Uint8List im = await AuthController().pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });

  }
   //snackbar, loading
   signUpUser() async{
        setState(() {
          _isLoading = true;
        });
        String res= await AuthController().signUpUsers(
           _fullNameController.text,
            _userNameController.text,
            _emailController.text,
            _phoneNumberController.text,
            _passwordController.text,
            _image
       );

        setState(() {
          _isLoading= false;
        });
       if(res != "success") {
         return showSnackBar(res, context);
       } else{
         return showSnackBar("Tebrikler, Hesap Oluşturuldu", context);
       }
       
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image==null?
              CircleAvatar(
              radius: 64,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(ImageItems().defaultpp),
              ): CircleAvatar(
                 radius: 64,
                 backgroundColor: Colors.grey.shade200,
                 backgroundImage: MemoryImage(_image!),

        ),
                  Positioned(
                    right: 5,
                    bottom: 10,
                    child: InkWell(
                      onTap: selectImage,
                      child: Icon(
                          Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TextKutulari(hinttext: "Full Name",kontrolcu: _fullNameController,),
              SizedBox(height: 20,),
              TextKutulari(hinttext: "Username",kontrolcu: _userNameController,),
              SizedBox(height: 20),
              TextKutulari(hinttext: "Email", kontrolcu: _emailController,),
              SizedBox(height: 20),
              TextKutulari(hinttext: "Phone Number", kontrolcu: _phoneNumberController,keyboard: TextInputType.phone,),
              SizedBox(height: 20),
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
                   signUpUser();
                   _fullNameController.clear();
                   _userNameController.clear();
                   _emailController.clear();
                   _passwordController.clear();
                   _image!.clear();
                 },
               child: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.white)): Text(
                 "Hesap Oluştur",
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
                  Text('Zaten hesabın var mı?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>  LoginScreen()));

                    },
                    child: Text('Giriş Yap',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



class AvatarImage extends StatelessWidget {
  const AvatarImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      radius: 64,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: NetworkImage(ImageItems().defaultpp),

    );
  }
}


class ImageItems {
  final String defaultpp = "https://www.andupoint.online/assets//img/reglog/defaultpp.images";

}

