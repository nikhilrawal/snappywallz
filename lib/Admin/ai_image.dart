import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:snappywalls/service/service.dart';

class AiImage extends StatelessWidget {
  final String imagepath;
  AiImage({
    Key? key,
    required this.imagepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
              tag: imagepath,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: imagepath,
                  placeholder: (context, imagepath) {
                    return Center(
                      child: SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Hang On! Almost there',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    strokeWidth: 8,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.teal),
                                  ),
                                  Text('⏳', style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              )),
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
                        Fluttertoast.showToast(
                            msg:
                                "Do not click anywhere, Image is being uploaded",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        uploadItem(imagepath);
                      },
                      child: Container(
                        height: 80,
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
                            "Add to 'AI' in your Virtual Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                foreground: Paint()
                                  ..style = PaintingStyle.fill
                                  ..color = Colors.black, // Inner color
                                shadows: [
                                  Shadow(
                                    blurRadius: 2.0,
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
          ),
          Positioned(
              left: 20,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(Icons.close),
                ),
              ))
        ],
      ),
    );
  }

  Future<File> urlToFile(String imageUrl) async {
    // Step 1: Download the image
    final http.Response response = await http.get(Uri.parse(imageUrl));

    // Step 2: Get the directory to save the file
    final Directory directory =
        await getTemporaryDirectory(); // You can also use getApplicationDocumentsDirectory for permanent storage

    // Step 3: Create a file path with the appropriate extension
    final String fileName =
        basename(imageUrl); // Extracts the file name from the URL
    final File file = File('${directory.path}/$fileName');

    // Step 4: Write the downloaded image as a file
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  uploadItem(String imageurl) async {
    File selectedImage = await urlToFile(imageurl);
    String ranId = randomAlphaNumeric(10);
    Reference firebaseStorage =
        FirebaseStorage.instance.ref().child('ai').child(ranId);
    final UploadTask task = firebaseStorage.putFile(selectedImage);
    var downloadUrl = await (await task).ref.getDownloadURL();
    Map<String, dynamic> addItem = {
      'Image': downloadUrl,
      'Id': ranId,
    };
    await DatabaseMethods().addWallpaper(addItem, ranId, 'AI');

    Fluttertoast.showToast(
        msg: "Image has been uploaded successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
