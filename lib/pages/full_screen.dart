// Add this import for web support
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:io';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class FullScreen extends StatefulWidget {
  final String imagepath;
  FullScreen({
    Key? key,
    required this.imagepath,
  }) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Hero(
            tag: widget.imagepath,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.imagepath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setImageAsWallpaperfromUrl(widget.imagepath);
                      },
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(156, 255, 255, 255),
                            Color.fromARGB(139, 177, 177, 177)
                          ]),
                        ),
                        child: Center(
                          child: Text(
                            "Download to set Wallpaper",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                foreground: Paint()
                                  ..style = PaintingStyle.fill
                                  ..color = Colors.black, // Inner color
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Colors.white,
                                    offset: Offset(1.0, 1.0),
                                  ),
                                ],
                                fontSize: 18,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(156, 255, 255, 255),
                            Color.fromARGB(139, 159, 158, 158)
                          ]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cancel",
                              style: TextStyle(
                                  color: const Color.fromARGB(232, 0, 0, 0),
                                  fontSize: 16,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 0.5,
                                      color: Colors.white,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  } // Add this import for web support

  Future<void> setImageAsWallpaperfromUrl(String url) async {
    // For mobile platforms, use your original method
    // Use the setImageAsWallpaperfromUrl logic for Android/iOS
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Define the Downloads folder path
        String downloadsPath = '/storage/emulated/0/Download';

        // Create the file path with a unique name
        String fileName =
            'snappyWalls_${DateTime.now().millisecondsSinceEpoch}.png';
        String filePath = path.join(downloadsPath, fileName);

        // Download the image using Dio
        Dio dio = Dio();
        await dio.download(url, filePath);

        print("Image downloaded to: $filePath");
        Fluttertoast.showToast(
            msg: "Image saved in Downloads!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } catch (e) {
        print("Error downloading image: $e");
        Fluttertoast.showToast(
            msg: "There was some problem",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      print("Permission denied");
    }
  }
}
