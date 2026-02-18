
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class Amazingcontainer extends StatelessWidget {
  const Amazingcontainer({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text("Amazing!", style: Textstyles.medium20),
            SizedBox(height: 8),
            Text(
              "With Some Practice you will be able to",
              style: Textstyles.medium13.copyWith(color: Color(0xff1E1E7B)),
            ),
            Text(
              "remember them all without much effort",
              style: Textstyles.medium13.copyWith(color: Color(0xff1E1E7B)),
            ),
          ],
        ),
      ),
    );
  }
}
