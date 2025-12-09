import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/CustomWidgets/CustomButton.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int start = 59; // عدد الثواني للتايمر
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEAFA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            
              Stack(
                children: [
                 Image.asset(
                  "Assets/images/Secure lock and key, successfully unlocked.png",
                  width: 328,
                  height: 274,
                ),
                
            Positioned(
              right: 0,left: 0,
              bottom: -10,
              child: Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  "Enter Your OTP",
                  
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Color(0xff1E1E7B),
                  ),
                ),
              ),
            ),

                ],
              ),
            
            SizedBox(height: 16),
            Text(
              textAlign: TextAlign.center,
              "For your security, We have sent A One-Time Code to your email user@gmail.com. Enter It to access your account.",
              style: TextStyle(fontSize: 13, color: Color(0xff999999)),
            ),
            SizedBox(height: 20),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [OtpInput(), OtpInput(), OtpInput(), OtpInput()],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "${start.toString()}s",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1E1E7B),
                  ),
                ),
                Text(
                  "  Remaining",
                  style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                ),
                Spacer(),
                GestureDetector(
                  onTap: start == 0
                      ? () {
                          setState(() {
                            start = 30;
                            startTimer();
                          });
                        }
                      : null,
                  child: Text(
                    "Resend Code?",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      color: Color(0xff1E1E7B),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(txt: "Verify"),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  const OtpInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff2B3574).withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      width: 64,
      height: 64,
      child: TextFormField(
        // keyboardAppearance:br ,
        keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
        decoration: InputDecoration(
          // hint:
          //  Container(height: 4, width: 0, color: Colors.black),
          contentPadding: EdgeInsets.all(20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
