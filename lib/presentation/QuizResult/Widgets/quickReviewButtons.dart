
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class QuickReviewButtons extends StatelessWidget {
  const QuickReviewButtons({super.key, required this.img, required this.txt, this.onpressed});
  final String img, txt;
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Color(0xffADADEB),
            elevation: 3,
            minimumSize: Size(34, 34),
            padding: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            // padding: EdgeInsets.all(8),
            backgroundColor: Color(0xffADADEB),
            shadowColor: Color(0xffADADEB),
          ),
          onPressed: onpressed,
          child: Image.asset(img, height: 15, width: 15),
        ),
        Text(txt,style: Textstyles.medium13,)
      ],
    );
  }
}