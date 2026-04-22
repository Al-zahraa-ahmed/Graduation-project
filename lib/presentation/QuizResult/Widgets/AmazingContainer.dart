import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';

class Amazingcontainer extends StatelessWidget {
  const Amazingcontainer({super.key, required this.feedback});

  final String feedback;

  @override
  Widget build(BuildContext context) {
    // Use feedback from API, fallback to default message
    final displayText = feedback.isNotEmpty
        ? feedback
        : "With Some Practice you will be able to remember them all without much effort";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffD6D6F5),
      ),
      child: Center(
        child: Column(
          children: [
            Text(S.of(context).result_amazing, style: Textstyles.medium20),
            SizedBox(height: 8),
            Text(
              displayText,
              style: Textstyles.medium13.copyWith(color: Color(0xff1E1E7B)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
