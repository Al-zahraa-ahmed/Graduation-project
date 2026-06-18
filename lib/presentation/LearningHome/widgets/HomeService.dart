
import 'package:flutter/material.dart';
import 'package:graduation_project/main.dart';

class HomeService extends StatelessWidget {
  const HomeService({
    super.key,
    required this.txt1,
    required this.txt2,
    required this.img,
  });
  final String txt1, txt2, img;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 328/100,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsetsDirectional.only(start: 4, bottom: 8, top: 8, end: 12),
        decoration: BoxDecoration(
          color: Color(0xffEAEAFA),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xffADADEB),
              spreadRadius: 0,
              offset: Offset(3, 3),
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(img, height: 41, width: 64),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    txt1,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  // SizedBox(height: 5,),
                  Padding(
                    padding:isArabic()? EdgeInsets.only(right: 0):const EdgeInsets.only(right: 26.0),
                    child: Text(
                      txt2,
                      style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
