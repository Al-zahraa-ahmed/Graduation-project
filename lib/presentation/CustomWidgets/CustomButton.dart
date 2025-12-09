import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/Otp/OtpPage.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        backgroundColor: Color(0xff8484E1),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (buildContext) {
              return OtpPage();
            },
          ),
        );
      },
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
