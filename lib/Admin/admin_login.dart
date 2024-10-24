import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snappywalls/Admin/a_i.dart';
import 'package:snappywalls/Admin/add_wallpaper.dart';
import 'package:snappywalls/Admin/create_acount.dart';
import 'package:snappywalls/secure/global.dart';

class AdminLogin extends StatefulWidget {
  final bool ai;
  const AdminLogin({super.key, this.ai = false});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> fkey = new GlobalKey<FormState>();
  TextEditingController usernameCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final route = widget.ai ? ArtificialUpload() : AddWallpaper();
    return loginstate.login
        ? route
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFededeb),
            body: Container(
              // padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(194, 15, 15, 15),
                          const Color.fromARGB(224, 14, 10, 10),
                          const Color.fromARGB(255, 0, 0, 0)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(
                            MediaQuery.of(context).size.width, 110),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: Form(
                      key: fkey,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Login to upload\nyour own image",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2.2,
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 155, 155, 47)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: TextFormField(
                                        controller: usernameCtrl,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter valid username";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Username',
                                            hintStyle: TextStyle(
                                                color: Colors.black45)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 155, 155, 47)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: TextFormField(
                                        controller: passwordCtrl,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter valid password";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                                color: Colors.black45)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              foregroundColor: Colors.black,
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.2,
                                                  55),
                                              backgroundColor: Colors.black),
                                          onPressed: () {
                                            if (fkey.currentState!.validate()) {
                                              FocusScope.of(context).unfocus();
                                              LoginAdmin();
                                            }
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 20,
                    right: 20,
                    child: Material(
                      elevation: 2,
                      shadowColor: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 105, 105, 105),
                        ),
                        height: 100,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminCreate()));
                            },
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Don't have an account? ",
                                children: [
                                  TextSpan(
                                    text: "Create now",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        fontSize: 19,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1)),
                                        ]),
                                  )
                                ],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  fontSize: 19,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(1, 1)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  LoginAdmin() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('admin')
        .doc(usernameCtrl.text)
        .get();
    if (snapshot.exists) {
      if (snapshot.get('password') == passwordCtrl.text.trim()) {
        loginstate.login = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Text(
              'Login Successful',
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.orangeAccent,
          ),
        );
        await Future.delayed(Duration(seconds: 1));
        Route route = widget.ai
            ? MaterialPageRoute(builder: (context) => ArtificialUpload())
            : MaterialPageRoute(builder: (context) => AddWallpaper());
        loginstate.login = true;
        Navigator.pushReplacement(context, route);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your Password is not correct',
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Your username is not correct',
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: Colors.orangeAccent,
        ),
      );
    }
  }
}
