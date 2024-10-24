import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:snappywalls/Admin/admin_login.dart';
import 'package:snappywalls/pages/full_screen.dart';
import 'package:snappywalls/service/service.dart';

class AllWallpaper extends StatefulWidget {
  final String category;
  AllWallpaper({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<AllWallpaper> createState() => _AllWallpaperState();
}

class _AllWallpaperState extends State<AllWallpaper> {
  Stream? categoryStream;
  getontheLoad() async {
    categoryStream = await DatabaseMethods().getCategory(widget.category);
    setState(() {});
  }

  Widget allWallpaper() {
    return StreamBuilder(
        stream: categoryStream,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data.docs.length != 0
              ? GridView.builder(
                  padding: EdgeInsets.only(top: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    print(ds['Image']);
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FullScreen(imagepath: ds['Image']))),
                      child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Hero(
                              tag: ds['Image'],
                              child: Image.network(
                                ds['Image'],
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    );
                  },
                )
              : Center(
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 118, 126, 139),
                    shadowColor: Colors.amberAccent,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                "You haven't added anything here",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 24,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            widget.category == 'AI'
                                                ? AdminLogin(
                                                    ai: true,
                                                  )
                                                : AdminLogin()));
                              },
                              child: Container(
                                height: 50,
                                width: 170,
                                margin: EdgeInsets.only(bottom: 30),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(53, 255, 255, 255),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        157, 255, 255, 255)),
                                child: Center(
                                  child: AnimatedTextKit(
                                    totalRepeatCount: 2,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        'Add Now',
                                        speed: Duration(milliseconds: 400),
                                        curve: Curves.easeIn,
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                185, 0, 0, 0),
                                            fontSize: 24,
                                            shadows: [
                                              Shadow(
                                                color: Colors.white,
                                                offset: Offset(1, 1),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getontheLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios)),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        widget.category,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: allWallpaper()),
          ],
        ),
      ),
    );
  }
}
