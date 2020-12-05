import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fanart/login.dart';
import 'package:fanart/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

/*
bool isLoggedIn() {
  bool flag;
  final _auth = FirebaseAuth.instance;
  while (flag == null)
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        flag = false;
      } else {
        print('User is signed in!');
        flag = true;
      }
    });

  print("Flag = " + flag.toString());
  return flag;
}
*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            child: Text("Something Went Wrong"),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(title: 'FanArt Demo', home: Login(), routes: {
            Home.id: (context) => Home(),
          });
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
