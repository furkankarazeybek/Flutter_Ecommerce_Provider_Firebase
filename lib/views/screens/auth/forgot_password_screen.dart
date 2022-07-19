import 'package:flutter/material.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';


class ForgotPasswordScreen extends StatefulWidget {
   ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false ;

  forgotPassword() async {
    setState(() {
      _isLoading= true;
    });
    String res = await AuthController().forgotPassword(_emailController.text);
    setState(() {
      _isLoading = false;
    });
    if(res== "success") {
      return showSnackBar('Bağlantı linki email adresinize gönderildi', context);
    } else {
      return showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Şifreyi Sıfırla',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 20,),
            // TextField(
            //   decoration: InputDecoration(
            //   hintText: "Email giriniz",
            //   filled: true,
            //   border: OutlineInputBorder(
            //       borderSide: BorderSide.none
            //    ),
            //   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.black)),
            //  ),
            // ),
            TextKutulari(hinttext:"Email giriniz", kontrolcu: _emailController),
            SizedBox(height: 20,),
            Container(
            width: MediaQuery.of(context).size.width -40,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,

            ),
            child: Center(
                child: GestureDetector(
                  onTap: forgotPassword,
                  child: _isLoading ? Center(child:CircularProgressIndicator(color: Colors.white)): Text(
                    "Şifreyi Sıfırla",
                    style: TextStyle(
                      color: textButton,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),

             ),
            ),
          ]
        ),
      ),
    );
  }
}
