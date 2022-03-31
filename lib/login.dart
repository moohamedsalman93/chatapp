import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebasehelper.dart';
import 'signup.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    //to find device size
    var media = MediaQuery.of(context);

    //object creation for firebase utils
    Service service = Service();
    //login button widget
    final log = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(13.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: 400.0,
        height: 60.0,
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          // if emai and password is not empty it will execute
          if (emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty &&
              nameController.text.isNotEmpty) {
            //firebaseAuth
            service.loginUser(
                context, emailController.text, passwordController.text);

            // it will save user email key and name in locally
            pref.setString("email", emailController.text);
            pref.setString('name', nameController.text);
          } else {
            //if textfield are empty it show earning message
            service.errorBox(context, 'fields must not be empty');
          }
        },
        child: const Text("Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return GestureDetector(
      //tap to hide keyboard function
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            //height: media.size.height * 1.05,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.topRight,
                colors: [
                  const Color.fromARGB(255, 9, 92, 245),
                  const Color.fromARGB(255, 1, 202, 252).withOpacity(0.5)
                ],
              ),
            ),
            child: ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
                                  child: Text(
                                    'Welcome to',
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Text(
                                    'Chat app',
                                    style: TextStyle(fontSize: 30),
                                  )),
                              SizedBox(
                                height: media.size.height * 0.009,
                              ),
                              ClipRRect(
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 5,
                                      sigmaY: 5,
                                    ),
                                    child: Container(
                                      height: media.size.height * 0.65,
                                      width: media.size.width * 1,
                                      margin: const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 40,
                                          bottom: 20),
                                      padding: const EdgeInsets.only(
                                          right: 20,
                                          left: 30,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              blurRadius: 0,
                                              offset: const Offset(7, 7),
                                            )
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: 300,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 3, 20, 3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                            child: const Text(
                                              "sign in page",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Container(
                                            width: 300,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 3, 20, 3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 0),
                                                )
                                              ],
                                            ),
                                            child: TextField(
                                              controller: nameController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "name",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: 300,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 3, 20, 3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 0),
                                                )
                                              ],
                                            ),
                                            child: TextField(
                                              controller: emailController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: 300,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 3, 20, 3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 0),
                                                )
                                              ],
                                            ),
                                            child: TextField(
                                              controller: passwordController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        143, 0, 0, 0)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 100,
                                                left: 100,
                                                top: 30,
                                                bottom: 10),
                                            child: log,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          60, 10, 0, 0),
                                                  child: const Text(
                                                    "Don't have an acoount",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  )),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Signup()));
                                                },
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 10, 0, 0),
                                                    child: const Text(
                                                      "Sign up",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ]))))),
      )),
    );
  }
}
