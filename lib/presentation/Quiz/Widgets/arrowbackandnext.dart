
import 'package:flutter/material.dart';

class Arrowbackandnext extends StatelessWidget {
  const Arrowbackandnext({super.key, required this.icon, this.onpressed});
  final Widget icon;
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(backgroundColor: Color(0xffD6D6F5)),
      color: Colors.black,
      onPressed:onpressed ,
      icon: icon
    );
  }
}