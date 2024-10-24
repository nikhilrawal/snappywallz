import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:snappywalls/pages/categories.dart';
import 'package:snappywalls/pages/home.dart';
import 'package:snappywalls/pages/search.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currIndex = 0;
  List<Widget> pages = [];
  late HomeScreen home;
  late Categories categories;
  late Search search;
  late Widget currentPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home = HomeScreen();
    categories = Categories();
    search = Search();
    currentPage = HomeScreen();
    pages = [home, search, categories];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          buttonBackgroundColor: Colors.black,
          color: Color.fromARGB(255, 89, 89, 89),
          backgroundColor: Colors.white10,
          animationDuration: Duration(milliseconds: 800),
          onTap: (value) {
            setState(() {
              currIndex = value;
            });
          },
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.category_outlined,
              color: Colors.white,
            )
          ],
        ),
        body: pages[currIndex],
      ),
    );
  }
}
