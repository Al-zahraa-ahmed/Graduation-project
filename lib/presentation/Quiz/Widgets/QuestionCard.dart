
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/VideoContainer.dart';

class QuistionCard extends StatelessWidget {
  const QuistionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 327 / 346,
      child: Container(
        width: 327,height: 346,
        margin: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xffADADEB),
              offset: Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 0.1,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text("Question 04 /10", style: Textstyles.medium20),
            SizedBox(height: 16),
            VideoContainer(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                60,
                (index) => Container(
                  width: 4,
                  height: 2,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("what does this sign mean ?", style: Textstyles.medium13),
          ],
        ),
      ),
    );
  }
}

