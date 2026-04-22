import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExamResult extends StatelessWidget {
  const ExamResult({super.key, required this.percentage});

  final int percentage;

  @override
  Widget build(BuildContext context) {
    final percent = (percentage.clamp(0, 100)) / 100;

    return CircularPercentIndicator(
      animation: true,
      radius: 50,
      lineWidth: 12,
      percent: percent,
      center: Text(
        "$percentage%",
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
