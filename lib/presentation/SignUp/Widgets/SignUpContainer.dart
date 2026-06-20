import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/Head1Text.dart';
import 'package:graduation_project/Core/CustomWidgets/MultiColorText.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LogIn/LoginScreen.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/GoogleOrFacebook.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/RegistrationForm.dart';
import 'package:graduation_project/presentation/SignUp/Widgets/SeparatorLine.dart';

/// Fixed bottom sheet anchored to the bottom of the sign-up screen.
/// Takes exactly 75% of the screen height regardless of keyboard state, and
/// the content scrolls internally. Border radius / color / shadow match the
/// login sheet so the two screens feel visually paired.
class SignupContainer extends StatelessWidget {
  const SignupContainer({super.key});

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
        color: Colors.white,
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
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 19),
          child: Column(
            children: [
              Head1Text(txt: "Get Started"),
              const SizedBox(height: 31),
              const RegistrationForm(),
              const SizedBox(height: 35),
              SeparatorLine(txt: S.of(context).or_signup_with),
              const SizedBox(height: 25),
              const GoogleOrFacebook(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Loginscreen()),
                  );
                },
                child: MultiColorText(
                  txt1: "Already have an account?",
                  txt2: S.of(context).login,
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
