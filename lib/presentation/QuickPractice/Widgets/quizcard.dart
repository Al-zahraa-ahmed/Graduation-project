
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 155 / 155,
      child: Container(
        width: 152,
        height: 155,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xffADADEB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(height: 5),
            Image.asset("Assets/images/family.png", height: 36, width: 36),
            SizedBox(height: 24),
            Text(
              S.of(context).family,
              style: Textstyles.medium20.copyWith(color: Colors.white),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Text(
                  S.of(context).familydec,
                  style: Textstyles.regular13.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
