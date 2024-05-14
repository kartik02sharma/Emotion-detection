
import 'dart:convert';

import 'package:face_detection/landing_screen.dart';
import 'package:face_detection/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController registeruseremailController = TextEditingController();
  final TextEditingController registerpasswordController = TextEditingController();
  final TextEditingController registerusernameController = TextEditingController();

  Future<void> register(String username,String useremail, String password) async {
    try {
      print(username);
      var response = await http.post(
        Uri.parse('http://192.168.3.73:5000/register'),
        body: jsonEncode({
          'name': username,
          'email': useremail,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // Navigate to the dashboard screen
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username already exist.Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Register Screen"),
        backgroundColor: Colors.grey,
        centerTitle: true,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Center(child: Image.asset('assets/images/facial-recognition-software.jpg',height: 300,width: 250,)),
                SizedBox(height: 10,),
                TextField(
                  controller: registerusernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "Username",
                    hintStyle: const TextStyle(
                        fontFamily: "mon", fontSize: 14, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: registeruseremailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    hintText: "Email",
                    hintStyle: const TextStyle(
                        fontFamily: "mon", fontSize: 14, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 10,),

                TextField(
                  controller: registerpasswordController,
                  obscureText: true,
                  decoration: InputDecoration(

                      prefixIcon: Icon(Icons.lock,color: Colors.blue,size: 16,),
                      hintText: "Password",
                      hintStyle: const TextStyle(
                          fontFamily: "mon", fontSize: 14, color: Colors.grey),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )

                  ),
                ),
                SizedBox(height: 20,),

                InkWell(
                  onTap: ()
                  {
            register(registerusernameController.text.toString(),registeruseremailController.text.toString(), registerpasswordController.text.toString());
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text("Register",style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(7)


                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

                      },
                      child: const Text("Already have account? Login Up")),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
