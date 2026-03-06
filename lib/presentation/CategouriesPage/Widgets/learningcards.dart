import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/data/Models/CategoryModel.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/presentation/CategouriesPage/Widgets/percentage.dart';

class LearningCards extends StatelessWidget {
  const LearningCards({super.key, required this.c, this.ontap});
  final CategoryModel c;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        children: [
          AspectRatio(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffD6D6F5),
                        child: Image.network(
                          color: Colors.white,
                          c.img.trim(),
                          height: 26,
                          width: 26,
                        ),
                      ),
                      Percentage(percentage: c.progress.toString()),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                    maxLines: 2,
                    isArabic() ? c.name.ar : c.name.en,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    isArabic() ? c.desc.ar : c.desc.en,
                    style: Textstyles.regular13.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: AlignmentGeometry.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Image.asset("Assets/images/Ellipse 2.png"),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: Image.asset(
              "Assets/images/arrow.png",
              width: 15,
              height: 13,
            ),
          ),
        ],
      ),
    );
  }
}
