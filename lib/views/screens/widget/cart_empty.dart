import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../feeds_screen.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 90),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height* 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/emptycart.png"),
              ),
            ),
          ),
          Text(
            "Your Cart is Empty",
            style: TextStyle(
              fontSize:30,
              fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: 15,),
          Container(
            width: MediaQuery.of(context).size.width -40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: Colors.pink,
              ),
              onPressed: () {},
              child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return FeedsScreen();
                      }));
                    },
                    child: Text(
                        "Shop Now",
                      style: TextStyle(
                          fontWeight: FontWeight.w600),
               ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
