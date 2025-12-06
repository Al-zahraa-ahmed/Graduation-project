import 'package:flutter/material.dart';

class SeparatorLine extends StatelessWidget {
  const SeparatorLine({super.key, required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xff999999)),
            ),
          ),
        ),
        Text(
          "   $txt   ",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xff999999),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xff999999)),
            ),
          ),
        ),
      ],
    );
  }
}
