
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExamResult extends StatelessWidget {
  const ExamResult({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      // fillColor: Colors.transparent
      animation: true,
      radius: 50,
      lineWidth: 12,
      percent: 0.9,
      center: Text(
        "90%",
        style: TextStyle(
          fontSize: 25,
          color: Color(0xff1E1E7B),
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Color(0xffEAEAFA),
      progressColor: Color(0xff8484E1),
    );
  }
}
