import 'package:commerce/APPAPAE.dart';
import 'package:commerce/ProfilePage.dart';
import 'package:commerce/cart.dart';
import 'package:commerce/detail.dart';
import 'package:commerce/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class item
{
 String imagepath;
 double price;
 String name;
 String location;
 item({required this.imagepath,required this.price,required this.name, this.location = "Main branch"});
}

class home extends StatefulWidget {
   home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final List<item> items = [
    item(name:'product 1',imagepath: 'image/new1.jpg', price: 120.99,location: 'nada shop'),
    item(name:'product 2',imagepath: 'image/new2.jpg', price: 340.99),
    item(name:'product 3',imagepath: 'image/new3.jpg', price: 564.99),
    item(name:'product 4',imagepath: 'image/new4.jpg', price: 987.99),
    item(name:'product 5',imagepath: 'image/new5.jpg', price: 213.99),
    item(name:'product 6',imagepath: 'image/new6.jpg', price: 098.99),
    item(name:'product 7',imagepath: 'image/new7.jpg', price: 76.99),
    item(name:'product 8',imagepath: 'image/new8.jpg', price: 540.99),
   
  ];

  @override
  Widget build(BuildContext context) {
    final Carttt = Provider.of<Cart>(context);

    return Scaffold(
      drawer:  Drawer(



          child: Container(
            color: Colors.white,
            child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

            Column(
            children: [
            // const UserAccountsDrawerHeader(
            // decoration: BoxDecoration(
            // image: DecorationImage(
            // image: AssetImage("image/sea.jpg"),
            // fit: BoxFit.cover),
            // ),
            //
            // accountName: Text("nadaaaa",
            // style: TextStyle(
            // color: Colors.black,
            // )),
            // accountEmail: Text("nada@yahoo.com",style: TextStyle(color: Colors.black),),
            // currentAccountPictureSize: Size.square(99),
            // currentAccountPicture: CircleAvatar(
            // radius: 55,
            // backgroundImage: AssetImage("image/gril.jpg")),
            // ),
              Image.asset('image/MMM.jpeg'),

            ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () { }
            ),

            ListTile(
            title: Text("My products"),
            leading: Icon(Icons.add_shopping_cart),
            onTap: () { }
            ),

            ListTile(
            title: Text("About"),
            leading: Icon(Icons.help_center),
            onTap: () { }
            ),
              ListTile(
                  title: Text("Profile Page"),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  }
              ),


              ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {

    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(

        MaterialPageRoute(builder: ((context) => signup())));
    }


            ),

            ],
            ),

                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Text("Developed by NadaMohamed © 2024",
                        style: TextStyle(fontSize: 16)),
                  )
                ],
            ),
          ),
      ),


      appBar:AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xffc8245c),
        title: Text("Home",style: TextStyle(color: Colors.white),),
        actions: [
       appapar()
        ],
      ) ,

      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 50),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> detail(product:items[index],)) );
                },
                child: GridTile(

                    child: Card(

                        child: Image.asset(items[index].imagepath,)),
                  footer: GridTileBar(
        // backgroundColor: Color.fromARGB(66, 73, 127, 110),
        //             trailing: IconButton(
        //                 color: Color.fromARGB(255, 62, 94, 70),
        //                 onPressed: () {
        //                   Carttt.add(items[index]);
        //                 },
        //                 icon: Icon(Icons.add,size: 20,)),//RIGHT
                    trailing:  ClipOval(
                      child: Material(
                        color: Color(0xffc8245c), // Button color
                        child: InkWell(
                          splashColor: Colors.redAccent, // Splash color
                          onTap: () {
                            Carttt.add(items[index]);
                          },
                          child: SizedBox( child: Icon(Icons.add,size: 20,)),
                        ),
                      ),
                    ),

                    //leading: Text("\$12.99",style: TextStyle(fontSize: 10,color:Colors.black26),),//LEFT

                    title: Text("",),//CENTER
                  ),  ),




              );
            }),
      ),
    );
  }
}
