import 'package:flutter/material.dart';

class MultiColorText extends StatelessWidget {
  const MultiColorText({super.key,required this.txt1,required this.txt2});
  final String txt1, txt2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$txt1",
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13, color: Color(0xff999999)),
        ),
        Text(
          " $txt2",
          style: TextStyle(
            fontSize: 13,
            // color: Color(0xff1E1E7B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
class MultiColorText2 extends StatelessWidget {
  const MultiColorText2({super.key,required this.txt1,required this.txt2});
  final String txt1, txt2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$txt1",
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        Text(
          " $txt2",
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff8484E1),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}