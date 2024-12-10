import 'package:commerce/cart.dart';
import 'package:commerce/checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class appapar extends StatelessWidget {
  const appapar({super.key});

  @override
  Widget build(BuildContext context) {
    final Carttt = Provider.of<Cart>(context);
    return   Row(
      children: [
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> checkout()));
                },
                icon: Icon(Icons.add_shopping_cart,color: Colors.white,)),

            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(211, 164, 255, 193),
                shape: BoxShape.circle,),
              child: Text(
                "${Carttt.selectedProducts.length}",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],

        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text( "\$ ${Carttt.price}",style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
