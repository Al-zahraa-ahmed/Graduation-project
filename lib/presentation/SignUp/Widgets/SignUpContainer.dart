import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/Head1Text.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/presentation/LogIn/LoginScreen.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/GoogleOrFacebook.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/RegistrationForm.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/SeparatorLine.dart';

class SignupContainer extends StatelessWidget {
  const SignupContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 19),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff2B3574).withValues(alpha: 0.5),
            offset: Offset(8, 8),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Head1Text(txt: "Get Started"),
          SizedBox(height: 31),
          RegistrationForm(),
          SizedBox(height: 35),
          SeparatorLine(txt: "Or sign up with"),
          SizedBox(height: 25),
          GoogleOrFacebook(),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (buildContext) {
                    return Loginscreen();
                  },
                ),
              );
            },
            child: MultiColorText(
              txt1: "Already have an account?",
              txt2: "Log in",
            ),
          ),
        ],
      ),
    );
  }
}
