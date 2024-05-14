import 'dart:convert';

import 'package:face_detection/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'ApiResponse.dart';


class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override

  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late List<CameraDescription> cameras;
  late CameraController _controller;
   List<ApiResponse> apiresponse=[];
  bool isvisible=false;


  Future<void> initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
  }
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  // @override
  // void happy(){  setState(() {child:Text("Happy");
  // print("Happy");});}
  // void clean(){  setState(() {child:Text("Sad");
  // print("sad");});
  //
  // }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(""),
          // automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: ()

        {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));}, icon: Icon(Icons.logout)),
  ]  ),

        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera,color: Colors.white,),
          onPressed: ()async { final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
            print("XXX");
          final url = Uri.parse('https://api.cloudinary.com/v1_1/dsrytqaju/upload');
          final request = http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = 'mbzizlnw'
            ..files.add(await http.MultipartFile.fromPath('file', image!.path));
          print("sSENDING");
          final response = await request.send();
          print(response.statusCode);
          if (response.statusCode == 200) {
            final responseData = await response.stream.toBytes();
            final responseString = String.fromCharCodes(responseData);
            final jasonMap = jsonDecode(responseString);
            final url = jasonMap['url'];
            String  imageUrl = url;
            print(imageUrl);
            var response1 = await http.post(
              Uri.parse('https://emotion-detection2.p.rapidapi.com/emotion-detection'),
              body: jsonEncode({
                'url': imageUrl

              }),
              headers: {'Content-Type': 'application/json',
    'X-RapidAPI-Key':'44189b0a34msh2c30291f3f5fba9p1c5e65jsnf27012b5632d',
    'X-RapidAPI-Host':'emotion-detection2.p.rapidapi.com'},
            );


            if (response1.statusCode == 200) {
              // Navigate to the dashboard screen
              apiresponse=apiResponseFromJson((response1.body));
              print(apiresponse.first.emotion!.value);
             print(response1.body);
             setState(() {
               isvisible=true;
             });
            } else {
              // Show error message
              print(response1.body);
            }

          }

            // or Pick Image from Gallery
            // final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

          },

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(width: 400, // Adjust the width as needed
                height: 400, // Adjust the height as needed
                child: Image.asset('assets/images/face2.jpg'),

              ),
              apiresponse.isNotEmpty?Center(
                child: Container(


                 child:
                     Visibility(visible: isvisible,
                     child: Text(apiresponse?.first?.emotion?.value?? ''),),
                  width: 400, // Adjust the width as needed
                  height: 400,

                ),
              ):SizedBox()

            ],
          ),
        )




    );

  }
}
