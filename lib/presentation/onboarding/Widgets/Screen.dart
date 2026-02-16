
import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/onboarding/Widgets/SkipWord.dart';

class screen1 extends StatelessWidget {
  const screen1({
    super.key,
    required this.img,
    required this.txt1,
    required this.txt2,
  });
  final String img, txt1, txt2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        SkipWord(),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 10.0),
          child: Stack(
            alignment: AlignmentGeometry.center,
            clipBehavior: Clip.none,
            children: [
              Image.asset("Assets/images/Rectangle 6.png"),
              Positioned(child: Image.asset(img)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt1,
                style: TextStyle(
                  color: Color(0xff1E1E7B),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                txt2,
                style: TextStyle(
                  color: Color(0xff999999),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}