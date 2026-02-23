import 'package:flutter/material.dart';

class GoogleOrFacebook extends StatelessWidget {
  const GoogleOrFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("Assets/images/Vector.png", height: 35, width: 35),
        // SizedBox(width: 30),
        // Image.asset("Assets/images/Vector (1).png", height: 40, width: 40),
      ],
    );
  }
}
