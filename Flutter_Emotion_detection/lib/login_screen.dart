import 'dart:convert';

import 'package:face_detection/register_screen.dart';
import 'package:face_detection/landing_screen.dart';


import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> login(String username, String password) async {
    try {
      print(username);
      var response = await http.post(
        Uri.parse('http://192.168.3.73:5000/login'),
        body: jsonEncode({
          'email': username,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print(username);
      print(password);

      if (response.statusCode == 200) {
        // Navigate to the dashboard screen
        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password. Please try again.'),
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
        title: Text("LOG IN "),
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
                Center(
                  child: Image.asset(
                    'assets/images/facial-recognition-software.jpg',
                    height: 300,
                    width: 250,
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "Username",
                    hintStyle: const TextStyle(
                      fontFamily: "mon",
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.blue, size: 16,),
                    hintText: "Password",
                    hintStyle: const TextStyle(
                        fontFamily: "mon", fontSize: 14, color: Colors.grey),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                   // print(usernameController.text.toString());
                   // print(passwordController.text.toString());
                    login(usernameController.text.toString(), passwordController.text.toString());
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text("Login", style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Registerscreen()));
                    },
                    child: const Text("Don't have account? Sign Up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
