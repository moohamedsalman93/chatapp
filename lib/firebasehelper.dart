import 'package:chatapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class Service {
  final auth = FirebaseAuth.instance;
  // for create user we define function
  void createUser(context, email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Chat()))
              });
    } catch (e) {
      errorBox(context, e);
    }
  }

  //for login user we define loginuser
  void loginUser(context, email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Chat()))
              });
    } catch (e) {
      errorBox(context, e);
    }
  }

  //for signout user
  void signOut(context) async {
    try {
      await auth.signOut().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const loginpage()),
                (route) => false)
          });
    } catch (e) {
      errorBox(context, e);
    }
  }

// for error handling
  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: const Text('error'),
              content: Text(
                e.toString(),
                style: const TextStyle(color: Colors.cyan),
              ));
        });
  }
}
