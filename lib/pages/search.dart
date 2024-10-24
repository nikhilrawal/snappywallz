import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snappywalls/Admin/admin_login.dart';
import 'package:snappywalls/secure/global.dart';
import 'package:snappywalls/models/imageModel.dart';
// import 'package:snappywalls/Admin/a_i.dart';
import 'package:snappywalls/widgets/photos.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Photomodel> imageslist = [];
  TextEditingController sctrl = new TextEditingController();
  bool search = false;
  getImages(String query) async {
    await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=100'),
        headers: {"Authorization": loginstate.apikey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        Photomodel photomodel = new Photomodel.fromJsonMap(element);
        imageslist.add(photomodel);
        setState(() {
          search = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Center(
                child: Text(
                  "SnappyWalls",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffececf8)),
                child: TextField(
                  controller: sctrl,
                  // autofocus: true,
                  onSubmitted: (value) => setState(() {
                    imageslist = [];
                    getImages(sctrl.text);
                  }),
                  decoration: InputDecoration(
                    hintText: 'Search from web directly',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () => getImages(sctrl.text),
                        child: search
                            ? GestureDetector(
                                onTap: () => setState(() {
                                      imageslist = [];
                                      search = false;
                                    }),
                                child: Icon(Icons.close))
                            : Icon(Icons.search)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              search
                  ? wallpaper(imageslist, context)
                  : Column(children: [
                      SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.2,
                        height: 10,
                      ),
                      Center(
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 118, 126, 139),
                          shadowColor: Colors.amberAccent,
                          child: Container(
                              height: MediaQuery.of(context).size.height / 1.8,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/ai.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(20),
                              // width: MediaQuery.of(context).size.width * 0.8,
                              // height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.symmetric(
                                          horizontal: BorderSide(width: 0.5)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          22, 255, 255, 255),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Now convert your idea into an real image",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        color:
                                            const Color.fromARGB(207, 0, 0, 0),
                                        fontSize: 18,
                                        shadows: [
                                          Shadow(
                                            color: Colors.white,
                                            offset: Offset(0.5, 1.5),
                                          ),
                                          Shadow(
                                              color: Colors.blue,
                                              offset: Offset(0.8, 0.5))
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdminLogin(
                                                    ai: true,
                                                  )));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 30),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  53, 255, 255, 255),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              157, 255, 255, 255)),
                                      child: Center(
                                        child: AnimatedTextKit(
                                          totalRepeatCount: 3,
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              'Add Now',
                                              speed:
                                                  Duration(milliseconds: 200),
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
                      ),
                    ]),
            ],
          )),
    );
  }
}
