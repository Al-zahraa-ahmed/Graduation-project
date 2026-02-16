
import 'package:flutter/material.dart';

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
      aspectRatio: 328/105,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.only(left: 4,bottom: 8,top: 8,right: 50),
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
                  SizedBox(height: 5,),
                  Text(
                    txt2,
                    style: TextStyle(fontSize: 13, color: Color(0xff999999)),
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
