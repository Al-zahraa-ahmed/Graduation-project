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
                          c.img.trim(),
                          color: Colors.white,
                          height: 26,
                          width: 26,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            );
                          },
                          errorBuilder: (context, _, __) => const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      Percentage(percentage: c.progress.toString()),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    isArabic() ? c.name.ar : c.name.en,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      isArabic() ? c.desc.ar : c.desc.en,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Textstyles.regular13
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: isArabic()
                ? AlignmentDirectional.centerEnd
                : AlignmentGeometry.centerRight,
            child: Padding(
              padding: isArabic()
                  ? const EdgeInsetsDirectional.only(end: 1.0)
                  : const EdgeInsets.only(right: 1.0),
              child: Transform.flip(
                flipX: isArabic(),
                child: Image.asset("Assets/images/Ellipse 2.png"),
              ),
            ),
          ),
          Align(
            alignment: isArabic()
                ? AlignmentDirectional.centerEnd
                : AlignmentGeometry.centerRight,
            child: Transform.flip(
              flipX: isArabic(),
              child: Image.asset(
                "Assets/images/arrow.png",
                width: 15,
                height: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
