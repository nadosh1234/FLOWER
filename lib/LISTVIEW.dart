import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class textfield extends StatelessWidget {

TextInputType textinput;
bool ischeck;
String text;
textfield({
     required this.textinput,required this.ischeck,required this.text
});

  @override
  Widget build(BuildContext context) {
    return TextField(

        keyboardType: textinput,
        obscureText: ischeck,
        decoration: InputDecoration(
          hintText: text,
          // To delete borders
          enabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide(context),),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
          // fillColor: Colors.red,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ));




  }
}
