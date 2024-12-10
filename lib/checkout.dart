import 'package:commerce/APPAPAE.dart';
import 'package:commerce/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class checkout extends StatelessWidget {
  const checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final Carttt = Provider.of<Cart>(context);
    return Scaffold(
       appBar:AppBar(
         iconTheme: IconThemeData(color: Colors.white),
         actions: [appapar()],
         title: Text('Check out',style: TextStyle(color: Colors.white),),
         backgroundColor: Color(0xffc8245c),
       ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 550,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: Carttt.selectedProducts.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Card(
                        child: ListTile(
                          title: Text(Carttt.selectedProducts[index].name),
                          subtitle: Text(
                              "${Carttt.selectedProducts[index].price} - ${Carttt.selectedProducts[index].location}"),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                Carttt.selectedProducts[index].imagepath),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Carttt.delete(Carttt.selectedProducts[index]);
                              },
                              icon: Icon(Icons.remove)),
                        ),
                      );
                    }),
              ),
            ),
            Container(
              width: 250,

              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Pay \$${Carttt.price}",
                  style: TextStyle(fontSize: 19,color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xffc8245c)),

                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
              ),
            ),
          ],
        ),
      ),






    );
  }
}
