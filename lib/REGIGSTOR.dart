import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/LISTVIEW.dart';
import 'package:commerce/signup.dart';
import 'package:commerce/snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' show basename, url;


class regigstor extends StatefulWidget {
   regigstor({super.key});

  @override
  State<regigstor> createState() => _regigstorState();
}

class _regigstorState extends State<regigstor> {
  bool isLoading = false;
  bool isvisablity=true;
  final _formKey = GlobalKey<FormState>();
  final credential = FirebaseAuth.instance.currentUser;
  String? imgName;
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPassword8Char = false;
 bool isPasswordhas1number=false;
 bool  Passwordhuppercase=false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  File? imgPath;
  onPasswordChanged(String password) {

    isPassword8Char = false;
    isPasswordhas1number=false;
    Passwordhuppercase=false;
    hasLowercase = false;
    hasSpecialCharacters = false;

    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordhas1number = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        Passwordhuppercase = true;
      }

      if (password.contains(  RegExp(r'[a-z]')     )) {
        hasLowercase = true;
      }

      if (password.contains( RegExp(r'[!@#$%^&*(),.?":{}|<>]')     )) {
        hasSpecialCharacters = true;
      }



    });
  }
  //image from camera or mobile
  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(

          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 20,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


//image
  uploadImage2Screen(ImageSource sss) async {
    final pickedImg = await ImagePicker().pickImage(source: sss);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
           imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";





          print(imgName);

        });
      } else {print("NO img selected");}
    } catch (e) {print("Error => $e");}
  }


  register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailController.text,
        password:  passwordController.text,
      );
      //
      // final storageRef = FirebaseStorage.instance.ref(imgName);
      // await storageRef.putFile(imgPath!);

     // String url = await storageRef.getDownloadURL();
      print(credential.user!.uid);


    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {

        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        //print('The account already exists for that email.');
        showSnackBar(context, "The account already exists for that email.");
      }
      else
        {
          showSnackBar(context, 'ERROR - Please try again late');
        }
    }

    CollectionReference user = FirebaseFirestore.instance.collection('userrrs');
    user.doc('usemmm').set({
      //'imgLink':url,
      'username': usernameController.text,
      'age': ageController.text,
      "title": titleController.text,
      "email": emailController.text,
      "pass":  passwordController.text,
    }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));



    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xffc8245c),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Regigster',style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 20),
          child: ListView(

            children: [

              Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(125, 78, 91, 110),),
                child: Center(
                  child: Stack(
                    children: [
                                  imgPath == null?
                      CircleAvatar(
                        backgroundColor:
                        Color.fromARGB(255, 225, 225, 225),
                        radius: 71,

                        backgroundImage: AssetImage("image/person.jpg"),

                      ):
                      ClipOval(
                        child: Image.file(
                          imgPath!,
                          width: 145,
                          height: 145,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          left: 95,
                          bottom: -15,
                          child: IconButton(onPressed: (){
                            showmodel();
                      },icon: const Icon(Icons.add_a_photo),
                      ))

                    ],
                  ),
                ),
              ),

              SizedBox(height: 35,),
              TextFormField(
                //controller: emailmyController,
                controller: usernameController,
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.person),
                  labelText: "Name  ",
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
               SizedBox(height: 35,),

              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.back_hand_rounded),
                  labelText: "Enter Your age  ",
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

              SizedBox(height: 35,),
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.person_2_outlined),
                  labelText: "Enter Your Title ",
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
              SizedBox(height: 35,),
              TextFormField(

                // we return "null" when something is valid
                validator: (email) {
                  return email!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))  ? null: "Enter a valid email" ;
                },

                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration(
                 // suffixIcon: Icon(Icons.email),
                  labelText: "Enter your Email  ",
                  filled: true,
                  fillColor: Color(0xffDFDFDF),
                  border:OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xffDFDFDF),),
                    borderRadius: BorderRadius.circular(5),
                  ),


                ),
              ),
              SizedBox(height: 35,),
              TextFormField(
                onChanged: (password) {
                  onPasswordChanged(password);
                },
                validator: (value) {return value!.length < 8 ? "Enter at least 6 characters": null;},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller:  passwordController,
                keyboardType: TextInputType.text,
                obscureText: isvisablity?true:false,
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      isvisablity=!isvisablity;
                    });
                  }, icon: isvisablity?Icon(Icons.visibility):Icon(Icons.visibility_off_outlined)),
                  labelText: "Enter your password  ",
                  filled: true,
                  fillColor: Color(0xffDFDFDF),
                  border:OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xffDFDFDF),),
                   // borderSide: BorderSide(color:Color(0xffDFDFDF)),
                    borderRadius: BorderRadius.circular(5),
                  ),


                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      isPassword8Char ? Colors.green : Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("At least 8 characters"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:   isPasswordhas1number ? Colors.green : Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("At least 1 number"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:  Passwordhuppercase ? Colors.green : Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("Has Uppercase"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasLowercase ? Colors.green : Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("Has  Lowercase "),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color:  Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasSpecialCharacters ? Colors.green : Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("Has  Special Characters "),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(height: 25,),


              ElevatedButton(
                onPressed: ()async {
    if(_formKey.currentState!.validate() &&
        imgName != null &&
        imgPath != null)      {
    await register();
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => signup()),
    );

    }

    else
    {
    showSnackBar(context, "error");
    }
    },




                child: isLoading
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
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
              ),









              SizedBox(height: 35,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have account?',
                      style: TextStyle(color: Colors.black, fontSize: 13)),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => signup()),
                      );
                    },

                    child: Text('Sign in',
                        style: TextStyle( color: Color(0xffc8245c),fontSize: 15)),),

                ],
              )


            ],
          ),
        ),
      ),


    ));
  }
}
