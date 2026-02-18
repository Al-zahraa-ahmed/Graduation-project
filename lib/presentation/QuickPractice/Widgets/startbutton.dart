import 'package:flutter/material.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Quiz/Quiz.dart';
import 'package:graduation_project/presentation/Quiz/quiz_chat.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        backgroundColor: Color(0xffD6D6F5),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (vuildcontext) {
              return QuizScreen();
            },
          ),
        );
      },
      child: Text(
        S.of(context).quiz_btn,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 13,
          color: Colors.black,
        ),
      ),
    );
  }
}
