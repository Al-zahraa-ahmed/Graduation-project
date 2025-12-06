import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/SignUpContainer.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEAFA),
      body: Column(
        children: [
          SizedBox(height: 100),
          Expanded(child: SingleChildScrollView(child: SignupContainer())),
        ],
      ),
    );
  }
}