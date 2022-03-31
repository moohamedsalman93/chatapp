// ignore_for_file: camel_case_types

import 'dart:ui';

import 'package:chatapp/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chatclone.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

var loginUser = FirebaseAuth.instance.currentUser;
ScrollController _scrollController = ScrollController();

class _ChatState extends State<Chat> {
  Service service = Service();

  final storeMessage = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController msg = TextEditingController();

  late SharedPreferences preferences;
  late String name = '';

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString('name');
    if (name == null) return;
    setState(() => this.name = name);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(255, 0, 140, 255),
          Color.fromARGB(255, 6, 218, 255),
        ],
      )),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: media.size.height * 0.025,
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      height: 140,
                      width: 370,
                      margin: const EdgeInsets.only(
                          right: 20, left: 20, top: 10, bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 0,
                              offset: const Offset(7, 7),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(' Room 169',
                                  style: TextStyle(
                                      fontFamily: 'Overpass',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              Text('user : ' + name,
                                  style: const TextStyle(
                                      fontFamily: 'Overpass',
                                      color: Colors.grey,
                                      fontSize: 21))
                            ],
                          ),
                          Expanded(child: Container()),
                          Column(children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 8, 0),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30)),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const dark()));
                                    },
                                    icon:
                                        const Icon(Icons.mode_night_rounded))),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 8, 0),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    service.signOut(context);
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.remove("email");
                                  },
                                  icon: const Icon(Icons.exit_to_app_rounded)),
                            )
                          ])
                        ]),
                      ),
                    ),
                  ),
                ),
                Flexible(
                    child: ClipRRect(
                        child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Container(
                              height: media.size.height * 0.7,
                              width: media.size.width * 0.9,
                              margin: const EdgeInsets.only(
                                  right: 20, left: 20, top: 0, bottom: 15),
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 0,
                                      offset: const Offset(7, 7),
                                    )
                                  ]),
                              child: const sa(),
                            )))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: media.size.height * 0.075,
                          width: media.size.width * 0.9,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  BorderRadiusDirectional.circular(28)),
                          child: TextField(
                            controller: msg,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "type msg...",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                if (msg.text.isNotEmpty) {
                                  storeMessage
                                      .collection("messages")
                                      .doc()
                                      .set({
                                    "sendby": name.toString(),
                                    "user": loginUser?.email.toString(),
                                    "text": msg.text.trim(),
                                    "time": DateTime.now()
                                  });
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.minScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                  msg.clear();
                                }
                              },
                              icon: const Icon(Icons.send_rounded)))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class sa extends StatelessWidget {
  const sa({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            //primary: true,
            controller: _scrollController,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data.docs[i];
              return ListTile(
                title: Column(
                    crossAxisAlignment: loginUser?.email == x['user']
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        // ignore: unrelated_type_equality_checks
                        decoration: loginUser?.email == x['user']
                            ? BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    const Color.fromARGB(255, 0, 140, 255)
                                        .withOpacity(0.5),
                                    const Color.fromARGB(255, 109, 0, 252)
                                        .withOpacity(0.5),
                                  ],
                                ))
                            : BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    const Color.fromARGB(255, 0, 140, 255)
                                        .withOpacity(0.5),
                                    const Color.fromARGB(255, 6, 218, 255)
                                        .withOpacity(0.5),
                                  ],
                                )),

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                x["sendby"],
                                style: TextStyle(
                                    color:
                                        // ignore: unrelated_type_equality_checks
                                        loginUser?.email == x['user']
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                x["text"],
                                style: TextStyle(
                                    color:
                                        // ignore: unrelated_type_equality_checks
                                        loginUser?.email == x['user']
                                            ? Colors.black
                                            : Colors.white),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(x["time"].toDate().toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 80, 80, 80),
                          )),
                    ]),
              );
            });
      },
    );
  }
}
