import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/Head1Text.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LogIn/Widgets/LoginForm.dart';
import 'package:graduation_project/presentation/SignUp/SignUpScreen.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/GoogleOrFacebook.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/SeparatorLine.dart';

/// Fixed bottom sheet anchored to the bottom of the login screen.
/// Takes exactly 70% of the screen height regardless of keyboard state, and
/// the content scrolls internally. Border radius / color / shadow are kept
/// identical to the previous card.
class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  static const _sheetHeightRatio = 0.75;
  static const _topRadius = Radius.circular(32);
  static const _borderRadius = BorderRadius.only(
    topLeft: _topRadius,
    topRight: _topRadius,
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * _sheetHeightRatio,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: _borderRadius,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2B3574).withValues(alpha: 0.5),
            offset: const Offset(8, 8),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      // Clip the scrolling content so it can't bleed out past the rounded
      // corners while the user scrolls fast.
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 19),
          child: Column(
            children: [
              Head1Text(txt: "welcome Back!"),
              const SizedBox(height: 51),
              const LoginForm(),
              const SizedBox(height: 25),
              SeparatorLine(txt: S.of(context).or_login_with),
              const SizedBox(height: 35),
              const GoogleOrFacebook(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignUp()),
                  );
                },
                child: MultiColorText(
                  txt1: "Don’t have an account",
                  txt2: S.of(context).signup,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
