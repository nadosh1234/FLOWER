import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/getdatefromfirestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
  @override









  uploadImage2Screen() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
    try {
      if (pickedImg != null) {
        setState(() {imgPath = File(pickedImg.path);});
      } else {print("NO img selected");}
    } catch (e) {print("Error => $e");}
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.green,
        title: Text("Profile Page",style: TextStyle( color: Colors.white,),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
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

                      backgroundImage: AssetImage("image/gril.jpg"),

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
                        bottom: -10,
                        child: IconButton(onPressed: (){
                          uploadImage2Screen();
                        },icon: const Icon(Icons.add_a_photo),
                        ))

                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
                child: Container(
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 131, 177, 255),
                      borderRadius: BorderRadius.circular(11)),
                  child: Text(
                    "Info from firebase Auth",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                )),
            SizedBox(
              height: 11,
            ),
            Text(
              "Email: ${credential!.email}      ",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Text(
              "Created date:   ${credential!.metadata.creationTime}    ",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Text(
              "Last Signed In:  ${credential!.metadata.lastSignInTime} ",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 10,
            ),


            TextButton(onPressed: (){
              final credential = FirebaseAuth.instance.currentUser;
              credential!.delete();



            }, child: Text('Delete',style: TextStyle(fontSize: 20),)),

            SizedBox(
              height: 10,
            ),

            Center(
                child: Container(
                    padding: EdgeInsets.all(11),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 131, 177, 255),
                        borderRadius: BorderRadius.circular(11)),
                    child: Text(
                      "Info from firebase firestore",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))),

            GetDataFromFirestore(documentId: credential!.uid,),
          ],
        ),
      ),
    );
  }
}