import 'package:commerce/LISTVIEW.dart';
import 'package:commerce/REGIGSTOR.dart';
import 'package:commerce/googlesignin.dart';
import 'package:commerce/home.dart';
import 'package:commerce/resentpassword.dart';
import 'package:commerce/snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  final emailmyController = TextEditingController();

  final passwordmyController = TextEditingController();
  bool isloading=false;
  bool isvisablity=false;
  signup()async
  {
    setState(() {
      isloading=true;
    });
    try {
       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailmyController.text,
          password: passwordmyController.text,
      );
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home()));

     // showSnackBar(context, 'done');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, '${e.code}');


    }
    setState(() {
      isloading=false;
    });
  }


  @override
  void dispose() {
    emailmyController.dispose();
    passwordmyController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return  SafeArea(child:
    Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1,
        backgroundColor: Color(0xffc8245c),
        title: Text('Sign in ',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,


            children: [
              SizedBox(height: 100,),
              TextField(
                controller: emailmyController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.email,color: Colors.black,),
                  labelText: "Enter You email  ",

                  filled: true,
                  fillColor: Color(0xffDFDFDF),
                  border:OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xffDFDFDF),),
                    //borderSide: BorderSide(color:Color(0xffDFDFDF)),
                    borderRadius: BorderRadius.circular(5),
                  ),


                ),
              ),
              //textfield(textinput: TextInputType.emailAddress, ischeck: false, text: 'enter You email:'),
             SizedBox(height: 25,),

             //textfield(textinput: TextInputType.number, ischeck: true, text: 'enter your password:'),


              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: passwordmyController,
                    keyboardType: TextInputType.text,
                    obscureText: isvisablity?true:false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed:(){
                        setState(() {
                          isvisablity=!isvisablity;
                        });


                      }, icon: isvisablity?Icon(Icons.visibility):Icon(Icons.visibility_off_outlined)),




                      labelText: "Enter You Password  ",
                      filled: true,
                      fillColor: Color(0xffDFDFDF),
                      border:OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Color(0xffDFDFDF),),
                        //borderSide: BorderSide(color:Color(0xffDFDFDF)),
                        borderRadius: BorderRadius.circular(5),
                      ),


                    ),
                  ),

                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => resentoassword()),);
                  }, child: Text('Forget password?',style: TextStyle(fontSize: 14,color:Colors.grey )),),


                ],
              ),

              SizedBox(height: 35,),

              ElevatedButton(
                onPressed: ()async {
                  await signup();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffc8245c)),
                 padding: MaterialStateProperty.all(EdgeInsets.only(left: 130,right: 130,top: 13,bottom: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(8))),
                ),
                       child: isloading
                ? CircularProgressIndicator(
                color: Colors.white,
              )
              : Text(
                        "Sign in",
                        style: TextStyle(fontSize: 19,  color: Colors.white,),
                ),
              ),






              SizedBox(height: 40,),
              Row(

                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                        indent: 5,
                        endIndent: 8,


                      ),
                    ),
                    Center(child: Text('OR')),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                        indent: 5,
                        endIndent: 8,


                      ),
                    ),

                  ],
              ),
              SizedBox(height: 20,), //icon google
          GestureDetector(
            onTap: () {
             setState(() {
               googleSignInProvider.googlelogin();
             });
            },
            child: Container(

              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black12,
                      //color: Color.fromARGB(255, 200, 67, 79),
                      width: 1)),
              child: Image.asset(
                "image/google.png",

                height: 55,
              ),
            ),
          ),
              SizedBox(height: 80,),
              Row(

mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do not have account?',style: TextStyle(color: Colors.black,fontSize: 15)),


                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => regigstor()),
                      );
                    },

                    child: Text('Sign up', style: TextStyle(fontSize: 13,color: Color(0xffc8245c))),),

                ],
              ),
            ],
          ),
        ),
      ),










    ));
  }
}
