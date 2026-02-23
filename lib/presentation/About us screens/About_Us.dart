import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),),
        elevation: 0,
        backgroundColor: Color(0xffD6D6F5),
        foregroundColor: Colors.black,
        title: const Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            // SizedBox(height: 10),

            Text(
              "SignLingo",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "SignLingo is an accessible educational application designed to support deaf and mute individuals in learning and practicing sign language through interactive and user-friendly features.",
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Our Mission",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Our mission is to bridge communication gaps and promote inclusivity by providing a safe, supportive, and innovative learning environment. We believe that communication is a right, not a privilege.",
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Our Vision",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "SignLingo is built with accessibility, clarity, and community in mind — empowering users to express themselves confidently and connect with others.",
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
