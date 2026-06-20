import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/data/Models/LessonsModel.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/main.dart';

class Lesson extends StatelessWidget {
  const Lesson({
    super.key,
    required this.l,
    required this.index,
    required this.isToggling,
    this.onToggle,
    this.onOpen,
  });

  final LessonsModel l;
  final int index;
  final bool isToggling;

  /// Tap the checkbox circle → toggle done state.
  final VoidCallback? onToggle;

  /// Tap the rest of the row → open the lesson video.
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 20.0, end: 8),
      child: Row(
        children: [
          // Checkbox circle: dedicated tap zone with circular ripple.
          Material(
            color: const Color(0xffD6D6F5),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: isToggling ? null : onToggle,
              customBorder: const CircleBorder(),
              splashColor: const Color(0x335B5BD7),
              highlightColor: const Color(0x1A5B5BD7),
              child: SizedBox(
                width: 42,
                height: 42,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: isToggling
                      ? const Center(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xff5B5BD7),
                            ),
                          ),
                        )
                      : CheckContainer(isselected: l.done),
                ),
              ),
            ),
          ),
          const SizedBox(width: 23),
          // Rest of the row → opens the video.
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onOpen,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).lessons_lesson_n(index),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff999999),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isArabic() ? l.name.ar : l.name.en,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (l.duration != null && l.duration!.isNotEmpty)
                        Text(
                          l.duration!,
                          style: Textstyles.medium13.copyWith(
                            color: const Color(0xff999999),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckContainer extends StatelessWidget {
  const CheckContainer({super.key, required this.isselected});
  final bool isselected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: isselected ? const Color(0xff5B5BD7) : null,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(width: 2, color: const Color(0xff5B5BD7)),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          fontWeight: FontWeight.w800,
          size: 14,
          color: isselected ? Colors.white : const Color(0xff5B5BD7),
        ),
      ),
    );
  }
}
