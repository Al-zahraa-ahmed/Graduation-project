import 'package:flutter/material.dart';

class Head1Text extends StatelessWidget {
  const Head1Text({super.key, required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontSize: 39,
        color: Color(0xff1E1E7B),
      ),
    );
  }
}
