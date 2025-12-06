import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/LogIn/Widgets/LoginContainer.dart';
class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEAFA),
      body: Column(
        children: [
          SizedBox(height: 250),
          Expanded(child: LoginContainer()),
        ],
      ),
    );
  }
}
