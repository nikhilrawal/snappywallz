import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:random_string/random_string.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snappywalls/Admin/admin_login.dart';
import 'package:snappywalls/secure/global.dart';
import 'package:snappywalls/models/imageModel.dart';
import 'package:http/http.dart' as http;
import 'package:snappywalls/pages/full_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photomodel> imagesplist = [];
  List<String> WallpaperImage = [];
  List<String> keywords = [
    'Wallpaper',
    'Cat',
    'Nature',
    'Wildlife',
    'Water',
    'Sky',
    'Butterfly',
    'Beautiful images'
  ];
  int count = 0;
  int activeIndex = 0;
  bool search = false;
  getImages(String query) async {
    await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=6'),
        headers: {"Authorization": loginstate.apikey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        Photomodel photomodel = new Photomodel.fromJsonMap(element);
        imagesplist.add(photomodel);
        WallpaperImage =
            imagesplist.map((photo) => photo.src!.portrait!).toList();
        setState(() {
          search = true;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int index = randomBetween(0, 7);
    getImages(keywords[index]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(60),
                        shadowColor: Colors.blue,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminLogin(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.person,
                              semanticLabel: 'Go to Admin',
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "User",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              shadows: [Shadow(color: Colors.blue)],
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                WavyAnimatedText('SnappyWalls',
                                    speed: Duration(milliseconds: 500),
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 0.3,
                                            color: const Color.fromARGB(
                                                153, 0, 0, 0),
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins')),
                                TyperAnimatedText('SnappyWalls',
                                    speed: Duration(milliseconds: 500),
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 0.3,
                                            color: const Color.fromARGB(
                                                153, 0, 0, 0),
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'))
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Expanded(
                child: Center(
                  child: !search
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 8,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.teal),
                            ),
                            Text('⏳', style: TextStyle(fontSize: 20)),
                          ],
                        )
                      : Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: WallpaperImage.length,
                              itemBuilder: (context, index, realIndex) {
                                final res = WallpaperImage[index];
                                return buildImage(context, res);
                              },
                              options: CarouselOptions(
                                autoPlay: true,
                                height:
                                    MediaQuery.of(context).size.height / 1.7,
                                enlargeCenterPage: true,
                                viewportFraction: 1,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    activeIndex = index;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(child: smoothIndicator(activeIndex, 6)),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget smoothIndicator(int activeIndex, int count) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect:
          SlideEffect(dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
    );
  }

  Widget buildImage(BuildContext context, String res) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullScreen(imagepath: res)));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 1.7,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Hero(
              tag: res,
              child: Image.network(
                res,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
//  Text(
//                           "SnappyWalls",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.black,
//                               shadows: [
//                                 Shadow(
//                                   blurRadius: 0.3,
//                                   color: Colors.blue,
//                                   offset: Offset(1.0, 1.0),
//                                 ),
//                               ],
//                               fontSize: 25.0,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Poppins'),
//                         ),