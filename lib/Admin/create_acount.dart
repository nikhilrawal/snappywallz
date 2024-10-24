import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:snappywalls/Admin/add_wallpaper.dart';
import 'package:snappywalls/Admin/admin_login.dart';

class AdminCreate extends StatefulWidget {
  const AdminCreate({super.key});

  @override
  State<AdminCreate> createState() => _AdminCreateState();
}

class _AdminCreateState extends State<AdminCreate> {
  final GlobalKey<FormState> fkey = new GlobalKey<FormState>();
  TextEditingController usernameCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  String text1 = "Is Batman better than Superman? Click to know!";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  top:
                      Radius.elliptical(MediaQuery.of(context).size.width, 110),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Form(
                key: fkey,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Create an account without hassle",
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
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 155, 155, 47)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextFormField(
                                  controller: usernameCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Are you being smart?\nPlease Enter Username";
                                    }
                                    if (value.length < 4) {
                                      return "Please enter atleast 4 characters";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter unique username',
                                      hintStyle:
                                          TextStyle(color: Colors.black45)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 155, 155, 47)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextFormField(
                                  controller: passwordCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter valid password";
                                    } else if (value.length > 4) {
                                      return "Please enter 4 digit password";
                                    } else if (!RegExp(r'^[0-9]+$')
                                        .hasMatch(value)) {
                                      return "Password must contain only digits";
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter a 4 digit Password',
                                      hintStyle:
                                          TextStyle(color: Colors.black45)),
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
                                                BorderRadius.circular(16)),
                                        foregroundColor: Colors.black,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                            55),
                                        backgroundColor: Colors.black),
                                    onPressed: () {
                                      if (fkey.currentState!.validate()) {
                                        CreateAccount();
                                      }
                                    },
                                    child: Text(
                                      'Create an account',
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
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (!text1.isEmpty && text1[0] == 'I')
                          setState(() {
                            text1 =
                                "Unpopular opinion but yes!!! Just kidding 😂";
                          });
                        else if (!text1.isEmpty && text1[0] == 'U') {
                          setState(() {
                            text1 = ":)";
                          });
                        } else {
                          setState(() {
                            text1 =
                                "Is Batman better than Superman? Click to know!";
                          });
                        }
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: text1,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 19,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(1, 1)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> CreateAccount() async {
    try {
      // Create a new document in Firestore with the entered username
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(usernameCtrl.text)
          .set({
        'password': passwordCtrl.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text(
            'Admin registered successfully! Remember your credentials for future',
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to the login screen or directly log the user in
      Route route = MaterialPageRoute(builder: (context) => AdminLogin());
      Navigator.pushReplacement(context, route);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error registering admin: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
