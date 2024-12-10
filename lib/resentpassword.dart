import 'package:commerce/REGIGSTOR.dart';
import 'package:commerce/signup.dart';
import 'package:commerce/snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class resentoassword extends StatefulWidget {
   resentoassword({super.key});

  @override
  State<resentoassword> createState() => _resentoasswordState();
}

class _resentoasswordState extends State<resentoassword> {
  final emailmyController = TextEditingController();
  bool isloading=false;
  final _formKey = GlobalKey<FormState>();

  forgetpassword()async
  {
    setState(() {
      isloading=true;
    });
    try {

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailmyController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signup()),
      );


      // showSnackBar(context, 'done');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, '${e.code}');


    }

  }

  void dispose() {
    emailmyController.dispose();

    super.dispose();
  }
  @override

  Widget build(BuildContext context) {



    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xffc8245c),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Resent Password',style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Text('Enter your email to sent your password ',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w800),),
           ),


           Padding(
             padding: const EdgeInsets.all(15),
             child:   TextFormField(

               // we return "null" when something is valid
               validator: (email) {
                 return email!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))  ? null: "Enter a valid email" ;
               },

               autovalidateMode: AutovalidateMode.onUserInteraction,
               controller: emailmyController,
               keyboardType: TextInputType.emailAddress,
               obscureText: false,
               decoration: InputDecoration(
                 suffixIcon: Icon(Icons.email),
                 labelText: "Enter your Email :  ",
                 filled: true,
                 fillColor: Color(0xffDFDFDF),
                 border:OutlineInputBorder(),
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color:Color(0xffDFDFDF),),
                   borderRadius: BorderRadius.circular(5),
                 ),


               ),
             ),
           ),
           SizedBox(height: 25,),

           ElevatedButton(
             onPressed: () async{
               if(_formKey.currentState!.validate()     ) {

                 forgetpassword();

               }
               else
               {
                 showSnackBar(context, "error");
               }
             },
             child: isloading
                 ? CircularProgressIndicator(
               color: Colors.white,
             )
                 : Text(
               "Register",
               style: TextStyle(fontSize: 19,  color: Colors.white,),
             ),

             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(
                   Color(0xffc8245c)),
               padding: MaterialStateProperty.all(EdgeInsets.only(left: 130,right: 130,top: 13,bottom: 13)),
               shape: MaterialStateProperty.all(RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8))),
             ),
           ),
         ],



        ),
      ),



    ));
  }
}
