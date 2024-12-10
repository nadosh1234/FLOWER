import 'package:commerce/REGIGSTOR.dart';
import 'package:commerce/cart.dart';
import 'package:commerce/checkout.dart';
import 'package:commerce/detail.dart';
import 'package:commerce/googlesignin.dart';
import 'package:commerce/home.dart';
import 'package:commerce/signup.dart';
import 'package:commerce/snakbar.dart';
import 'package:commerce/splach.dart';
import 'package:commerce/vertify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          title: "myApp",
          debugShowCheckedModeBanner: false,
          home:splach()

          // StreamBuilder(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //           child: CircularProgressIndicator(
          //             color: Colors.white,
          //           ));
          //     } else if (snapshot.hasError) {
          //       return showSnackBar(context, "Something went wrong");
          //     } else if (snapshot.hasData) {
          //       return home(); // home() OR verify email
          //     } else {
          //       return signup();
          //
          //     }
          //   },
          // )
      ),
    );
  }
}

