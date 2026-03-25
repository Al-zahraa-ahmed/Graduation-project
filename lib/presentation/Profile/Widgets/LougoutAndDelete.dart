import 'package:flutter/material.dart';

class LogoutAndDelete extends StatelessWidget {
  const LogoutAndDelete({
    super.key,
    required this.img,
    required this.title,
    this.c = Colors.black,
    this.ontap,
  });
  final String img, title;
  final Color c;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            Image.asset(img, width: 25, height: 25),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: c,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
