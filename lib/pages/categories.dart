import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:snappywalls/pages/all_wallpaper.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Virtual Gallery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Item(name: 'AI', path: 'images/ai.jpg'),
              Item(name: 'Wildlife', path: 'images/wildlife.png'),
              Item(name: 'Food', path: 'images/food.png'),
              Item(name: 'City', path: 'images/city.png'),
              Item(name: 'Nature', path: 'images/nature.png'),
              Item(name: 'Other', path: 'images/pic1.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String name;
  final String path;
  Item({
    Key? key,
    required this.name,
    required this.path,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllWallpaper(category: name),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(path,
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover),
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Center(
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    RotateAnimatedText(
                      name,
                      rotateOut: false,
                      duration: Duration(milliseconds: 4000),
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    ),
                    TyperAnimatedText(
                      name,
                      speed: Duration(milliseconds: 400),
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
