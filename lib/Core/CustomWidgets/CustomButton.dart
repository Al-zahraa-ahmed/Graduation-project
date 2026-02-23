import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.txt, this.onpressed,  this.c=const Color(0xff8484E1)});
  final String txt;
  final void Function()? onpressed;
  final Color c;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
        // backgroundColor: Colors.red,
        disabledBackgroundColor: c,

        backgroundColor: c,
      ),
      onPressed: onpressed,
      child: Text(
        txt,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
