import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/SignUp/SignUpScreen.dart';

void main() {
  runApp(const GraduationProject());
}

class GraduationProject extends StatelessWidget {
  const GraduationProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignUp());
  }
}










