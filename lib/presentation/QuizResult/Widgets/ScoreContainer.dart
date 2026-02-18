
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0.1,
            color: Color(0xffADADEB),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffD6D6F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Score", style: Textstyles.medium20),
              Text(
                "9",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 39,
                  color: Color(0xff1E1E7B),
                ),
              ),
              Text(
                "Out Of 10",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff1E1E7B),
                ),
              ),
            ],
          ),
          SizedBox(width: 48),
          Image.asset("Assets/images/prize.png", height: 52, width: 52),
          SizedBox(width: 48),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Time", style: Textstyles.medium20),
              Text(
                "170",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 39,
                  color: Color(0xff1E1E7B),
                ),
              ),
              Text(
                "Seconds",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff1E1E7B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
