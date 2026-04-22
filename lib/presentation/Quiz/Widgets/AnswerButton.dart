import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

enum AnswerState { normal, selected, correct, wrong, untouched }

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.text,
    this.answerState = AnswerState.normal,
    required this.onTap,
  });

  final String text;
  final AnswerState answerState;
  final VoidCallback? onTap;

  Color get _bgColor {
    switch (answerState) {
      case AnswerState.correct:
        return Color(0xff4BE765);
      case AnswerState.wrong:
        return Color(0xffCC0003);
      case AnswerState.selected:
        return Color(0xff7C7CD5);
      case AnswerState.normal:
        return Color(0xffADADEB);
      case AnswerState.untouched:
        return Color(0xffD9D9D9);
    }
  }

  Border? get _border {
    switch (answerState) {
      case AnswerState.correct:
        return Border.all(color: Color(0xff2DA840), width: 2);
      case AnswerState.wrong:
        return Border.all(color: Color(0xff990002), width: 2);
      case AnswerState.selected:
        return Border.all(color: Color(0xff1E1E7B), width: 2);
      case AnswerState.normal:
      case AnswerState.untouched:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _bgColor,
          border: _border,
        ),
        child: Center(
          child: Text(
            text,
            style: Textstyles.medium20.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
