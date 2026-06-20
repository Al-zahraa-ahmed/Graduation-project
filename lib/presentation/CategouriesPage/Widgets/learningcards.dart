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
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 155 / 155,
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: const Color(0xffADADEB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: ontap,
                borderRadius: BorderRadius.circular(12),
                splashColor: const Color(0x33FFFFFF),
                highlightColor: const Color(0x1AFFFFFF),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xffD6D6F5),
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
                          fontSize: 16,
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
            ),
          ),
        ),

        // Decorative overlays: wrapped in IgnorePointer so taps pass through
        // to the InkWell underneath (otherwise the ellipse/arrow images would
        // swallow taps near the corner and the ripple wouldn't fire).
        IgnorePointer(
          child: Align(
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
        ),
        IgnorePointer(
          child: Align(
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
        ),
      ],
    );
  }
}
