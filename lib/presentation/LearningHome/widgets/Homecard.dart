import 'package:flutter/material.dart';
import 'package:graduation_project/generated/l10n.dart';

class Homecard extends StatelessWidget {
  const Homecard({super.key, required this.txt1, required this.txt2, required this.img});
  final String txt1, txt2, img;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 351 / 158,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffEAEAFA),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xffADADEB),
              spreadRadius: 1,
              offset: Offset(2, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            top: 8,
            bottom: 8,
            right: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txt1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      txt2,
                      style: TextStyle(fontSize: 13, color: Color(0xff999999)),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4),
              Image.asset(img),
            ],
          ),
        ),
      ),
    );
  }
}
