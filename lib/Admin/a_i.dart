import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snappywalls/Admin/ai_image.dart';
import 'package:snappywalls/secure/global.dart';

class ArtificialUpload extends StatefulWidget {
  const ArtificialUpload({super.key});

  @override
  State<ArtificialUpload> createState() => _ArtificialUploadState();
}

class _ArtificialUploadState extends State<ArtificialUpload> {
  TextEditingController sctrl = TextEditingController();
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                WavyAnimatedText('SnappyWalls',
                                    speed: Duration(milliseconds: 200),
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
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Generate custom images with AI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Expanded(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'images/ai.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              color: const Color.fromARGB(48, 119, 131, 119),
                              borderRadius: BorderRadius.circular(20)),
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffececf8)),
                            child: TextField(
                              maxLength: 100,
                              controller: sctrl,
                              maxLines: 1,
                              onSubmitted: (value) {
                                setState(() {
                                  sctrl.text = sctrl.text.trim();
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'Type your prompt here',
                                  border: InputBorder.none,
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        if (sctrl.text.length < 3) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Please enter atleast 3 characters')));
                                        } else {
                                          setState(() {
                                            search = true;
                                            generateImage(sctrl.text.trim());
                                          });
                                        }
                                      },
                                      child: Icon(
                                          Icons.arrow_forward_ios_rounded))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                search
                    ? SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Column(
                            children: [
                              Text('We are working for your request'),
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
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      )
              ]))),
    );
  }

  Future<void> generateImage(String prompt) async {
    final Map<String, dynamic> body = {
      "jsonBody": {
        "function_name": "image_generator",
        "type": "image_generation",
        "query": "$prompt",
        "output_type": "png"
      }
    };

    final response = await http.post(
      Uri.parse(loginstate.apiUrl),
      headers: {
        "Content-Type": "application/json",
        "x-rapidapi-host": "ai-image-generator14.p.rapidapi.com",
        "x-rapidapi-key": loginstate.xrapidapikey
      },
      body: jsonEncode(body), // Encode the body to JSON
    );
    setState(() {
      search = false;
    });
    if (response.statusCode == 200) {
      // Handle the successful response
      final data = jsonDecode(response.body);

      // print(data['message']['output_png']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AiImage(
            imagepath: data['message']['output_png'],
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Some Error Occurred",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0);
      // Handle errors
      print('Failed to generate image: ${response.statusCode}');
      print(
          'Response: ${response.body}'); // Optional: Print response body for debugging
    }
  }
}
