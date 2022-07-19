import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../search_screen.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(children: [
        Flexible(
            flex: 1,
            child: Container(
              child: TextField(
                onTap : () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return SearchScreen();
                  }));
                },
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search for Products",
                  hintStyle: TextStyle(
                    color: Colors.grey,),
                  prefixIcon: Container(
                      padding: EdgeInsets.all(15),
                      child: Image.asset("assets/icons/search.png",
                          width:15),

                  ),
                ),
              ),
            ),
          ),
        Container(
           margin: EdgeInsets.only(left :10),
           padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset("assets/icons/filter.png",
            width: 25,
          ),
        ),
       ],
      ),
    );
  }
}
