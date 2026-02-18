
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:32 ),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffADADEB),
      ),
      child: Center(child: Text("Answer",style: Textstyles.medium20.copyWith(color: Colors.white),)),
    );
  }
}