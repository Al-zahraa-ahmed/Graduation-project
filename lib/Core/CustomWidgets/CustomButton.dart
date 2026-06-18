import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.txt,
    this.onpressed,
    this.c = const Color(0xff8484E1),
    this.isLoading = false,
  });
  final String txt;
  final void Function()? onpressed;
  final Color c;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
        disabledBackgroundColor: c,
        backgroundColor: c,
      ),
      onPressed: isLoading ? null : onpressed,
      child: isLoading
          ? SizedBox(
              height: 28,
              width: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
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
