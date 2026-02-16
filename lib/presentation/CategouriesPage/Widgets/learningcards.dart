
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/percentage.dart';

class LearningCards extends StatelessWidget {
  const LearningCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 155/155,
          child: Container(
            width: 152,
            height: 155,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xffADADEB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "Assets/images/family.png",
                      height: 36,
                      width: 36,
                    ),
                    Percentage(),
                  ],
                ),
                Expanded(child: SizedBox()),
                Text(
                  S.of(context).family,
                  style: Textstyles.medium20.copyWith(color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  S.of(context).familydec,
                  style: Textstyles.regular13.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),

        Align(alignment: AlignmentGeometry.centerRight,child: Padding(
          padding: const EdgeInsets.only(right: 1.0),
          child: Image.asset("Assets/images/Ellipse 2.png"),
        )),
        Align(alignment: AlignmentGeometry.centerRight,child: Image.asset("Assets/images/arrow.png", width: 15, height: 13)),
      ],
    );
  }
}

