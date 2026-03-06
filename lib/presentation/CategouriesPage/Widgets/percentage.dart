import 'package:flutter/material.dart';

class Percentage extends StatelessWidget {
  const Percentage({super.key, required this.percentage});
  final String percentage;
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
          percentage,
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
