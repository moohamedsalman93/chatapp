import 'package:chatapp/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase
  await Firebase.initializeApp();
  //declaring shared pref(local storage)
  SharedPreferences pref = await SharedPreferences.getInstance();    
  //toget saved email value from device(locally)
  var email = pref.get('email');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == null ? const loginpage() : const Chat(),
  ));
}
