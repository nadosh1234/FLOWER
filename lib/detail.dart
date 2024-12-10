import 'package:commerce/APPAPAE.dart';
import 'package:commerce/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class detail extends StatefulWidget {
   detail({super.key,required this.product});
   item product;


  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  bool ischeck=true;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xffc8245c),
        title: Text('Detail screen',style: TextStyle(color: Colors.white),),
        actions: [
          appapar()
        ],
      ) ,
      body: SingleChildScrollView(
        child: Column(children: [
        Center(child: Image.asset(widget.product.imagepath)),

          Text('\$ ${widget.product.price}',style: TextStyle(fontSize: 18,color: Colors.black),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

           Row(
             children: [
               Container(
                 padding: EdgeInsets.all(4),
                 decoration: BoxDecoration(
                     color: Color(0xffc8245c),
                     borderRadius: BorderRadius.circular(5)
                 ),
                 child: Text('NEW',style: TextStyle(color: Colors.black,fontSize: 10),),),
               SizedBox(width: 10,),


               Row(
                 children: [
                   Icon(Icons.star,color: Color(0xffc8245c),size: 15,),
                   Icon(Icons.star,color: Color(0xffc8245c),size: 15,),
                   Icon(Icons.star,color: Color(0xffc8245c),size: 15,),
                   Icon(Icons.star,color: Color(0xffc8245c),size: 15,),
                   Icon(Icons.star,color: Color(0xffc8245c),size: 15,),
                 ],),
             ],
           ),
             SizedBox(width: 30,),
             Row(
               children: [
                 Icon(Icons.edit_location,size: 20,),
                 SizedBox(width: 3,),
                 Text('flower shop',style: TextStyle(color: Colors.black),)
               ],
             )

          ],),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
              child: Text('Detail :',style: TextStyle(fontSize: 20,color: Colors.black,),textAlign: TextAlign.start,)),
          //SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('  also known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers consist of a combination of vegetative organs – sepals that enclose and protect the developing flower, petals that attract pollinators, and reproductive organs that produce gametophytes, which in flowering plants produce gametes. The male gametophytes, which produce sperm, are enclosed within pollen grains produced in the anthers. The female gametophytes are contained within the ovules produced in the carpels.',style: TextStyle(fontSize: 15,color: Colors.black26,),
              maxLines:ischeck  ?3 :null ,
              overflow: TextOverflow.fade,
              ),
          ),
          TextButton(onPressed: (){
            setState(() {
              ischeck=!ischeck;
            });
          }, child: Text(ischeck?'Show more':'Show less',style: TextStyle(fontSize: 18,color: Color(0xffc8245c)),))

        ],),
      ),
    );
  }
}

