import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snappywalls/service/service.dart';

class AddWallpaper extends StatefulWidget {
  const AddWallpaper({super.key});

  @override
  State<AddWallpaper> createState() => _AddWallpaperState();
}

class _AddWallpaperState extends State<AddWallpaper> {
  List<String> categories = [
    'Wildlife',
    'Nature',
    'Food',
    'City',
    'AI',
    'Others'
  ];
  bool search = false;
  String? value;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  Future getImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  uploadItem(String category) async {
    if (selectedImage != null) {
      String ranId = randomAlphaNumeric(10);
      Reference firebaseStorage =
          FirebaseStorage.instance.ref().child(value!).child(ranId);
      final UploadTask task = firebaseStorage.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addItem = {
        'Image': downloadUrl,
        'Id': ranId,
      };
      // var item =
      await DatabaseMethods().addWallpaper(addItem, ranId, value!);
      setState(() {
        search = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blueGrey,
          ),
        ),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Add in virtual gallery',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 20),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            selectedImage == null
                ? GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Center(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 250,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.add_a_photo_outlined),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 250,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    borderRadius: BorderRadius.circular(10),
                    value: value,
                    hint: Text("Select category"),
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    items: categories
                        .map((e) => DropdownMenuItem(
                              child: Text(
                                e,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              value: e,
                            ))
                        .toList()),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            search
                ? SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'We are working for your request\nKindly Wait',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                strokeWidth: 8,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.teal),
                              ),
                              Text('⏳', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (value != null && selectedImage != null) {
                        setState(() {
                          search = true;
                        });
                        uploadItem(value!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Select image and category',
                              style: TextStyle(fontSize: 24),
                            ),
                            backgroundColor: Colors.orangeAccent,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
