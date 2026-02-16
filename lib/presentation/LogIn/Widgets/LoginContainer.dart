
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/Head1Text.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/presentation/LogIn/Widgets/LoginForm.dart';
import 'package:graduation_project/presentation/SignUp/SignUpScreen.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/GoogleOrFacebook.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/SeparatorLine.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            Head1Text(txt: "welcome Back!"),
            SizedBox(height: 51),
            LoginForm(),
            SizedBox(height: 25),
            SeparatorLine(txt: "Or log in with"),
            SizedBox(height: 35),
            GoogleOrFacebook(),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (buildcontext) {
                      return SignUp();
                    },
                  ),
                );
              },
              child: MultiColorText(
                txt1: "Don’t have an account",
                txt2: "Sign up",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
