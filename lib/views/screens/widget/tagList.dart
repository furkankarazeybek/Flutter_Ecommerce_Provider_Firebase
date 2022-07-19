import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
   TagList({Key? key}) : super(key: key);

  final tagList = ['Woman',"T-shirt","Dress"];
  @override
  Widget build(BuildContext context) {
    return Row(children: tagList.map((a)=>
        Container(
          margin: EdgeInsets.all(14),
           padding: EdgeInsets.all(10),
           child: Text(a, style: TextStyle(color: Colors.grey),
      ),
    )).toList(),

    );
  }
}
