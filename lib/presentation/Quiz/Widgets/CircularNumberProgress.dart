
import 'package:flutter/material.dart';

class CircularNumberProgress extends StatelessWidget {
  final int number;
  final double progress; // من 0 لـ 1

  const CircularNumberProgress({
    super.key,
    required this.number,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        alignment: Alignment.center,
        children: [

          // 🔹 الدائرة الخارجية (الموف)
          SizedBox(
            width: 55,
            height: 55,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 14,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xffC9C7E8),
              ),
            ),
          ),

          // 🔹 الدائرة الداخلية (الصفراء)
          SizedBox(
            width: 45,
            height: 45,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 7,
              backgroundColor: Color(0xffF2C94C),
              valueColor: const AlwaysStoppedAnimation(
                // Color(0xffF2C94C),
                Colors.white,
              ),
            ),
          ),

          // 🔹 الرقم في النص
          Text(
            "$number",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

