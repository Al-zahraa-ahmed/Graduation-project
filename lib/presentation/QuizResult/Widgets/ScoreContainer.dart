import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.timeMins,
  });

  final int score;
  final int totalQuestions;
  final double timeMins;

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
              Text(S.of(context).result_score1, style: Textstyles.medium20),
              Text(
                "$score",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 39,
                  color: Color(0xff1E1E7B),
                ),
              ),
              Text(
                "${S.of(context).result_score2} $totalQuestions",
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
              Text(S.of(context).result_time, style: Textstyles.medium20),
              Text(
                timeMins.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 39,
                  color: Color(0xff1E1E7B),
                ),
              ),
              Text(
                S.of(context).result_minutes,
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
