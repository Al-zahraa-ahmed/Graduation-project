import 'package:flutter/material.dart';
import 'package:graduation_project/main.dart';

class HomeService extends StatelessWidget {
  const HomeService({
    super.key,
    required this.txt1,
    required this.txt2,
    required this.img,
    this.onTap,
  });
  final String txt1, txt2, img;
  final VoidCallback? onTap;

  static const _radius = 12.0;
  static const _surface = Color(0xffEAEAFA);
  static const _splash = Color(0x338484E1);
  static const _highlight = Color(0x1A8484E1);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 328 / 103,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffADADEB),
              spreadRadius: 0,
              offset: Offset(3, 3),
              blurRadius: 1,
            ),
          ],
        ),
        child: Material(
          color: _surface,
          borderRadius: BorderRadius.circular(_radius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(_radius),
            splashColor: _splash,
            highlightColor: _highlight,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 4,
                bottom: 8,
                top: 8,
                end: 12,
              ),
              child: Row(
                children: [
                  Image.asset(img, height: 41, width: 64),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          txt1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: isArabic()
                              ? EdgeInsets.zero
                              : const EdgeInsets.only(right: 26.0),
                          child: Text(
                            txt2,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff999999),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
