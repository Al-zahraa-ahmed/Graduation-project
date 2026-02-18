
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class VideoContainer extends StatelessWidget {
  const VideoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 250 / 150,
      child: Container(
        width: 250,height: 150,
        margin: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xffEAEAFA),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(size: 42, Icons.play_circle, color: Color(0xffADADEB)),
            SizedBox(height: 10),
            Text("Tap to play video", style: Textstyles.bold13),
          ],
        ),
      ),
    );
  }
}
