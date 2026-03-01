import 'package:flutter/material.dart';

class Lockpic extends StatelessWidget {
  const Lockpic({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "Assets/images/Secure lock and key, successfully unlocked.png",
          width: 328,
          height: 274,
        ),

        Positioned(
          right: 0,
          left: 0,
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
    );
  }
}