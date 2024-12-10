

import 'package:commerce/signup.dart';
import 'package:flutter/material.dart';

class splach extends StatefulWidget {
  const splach({super.key});

  @override
  State<splach> createState() => _splachState();
}

class _splachState extends State<splach> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 4));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const signup()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ClipOval(

              //backgroundColor: Color(0xffc8245c),
              child: Image.asset('image/FRF.webp',width: 160,height: 160,  fit:BoxFit.cover, ),
            ),
          ),
          SizedBox(height: 30,),
          Text('Flowera',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w400,color: Color( 0xffc8245c)),)

        ],
      ),
    );
  }
}
