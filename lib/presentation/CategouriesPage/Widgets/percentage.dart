
import 'package:flutter/material.dart';

class Percentage extends StatelessWidget {
  const Percentage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 26,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xffD6D6F5),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          "0%",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}