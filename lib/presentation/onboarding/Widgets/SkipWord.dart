
import 'package:flutter/material.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Appmodes/ChooseAppMode.dart';

class SkipWord extends StatelessWidget {
  const SkipWord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Align(
        alignment: AlignmentGeometry.centerRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (buildcontext) {
                  return OnboardingMode();
                },
              ),
            );
          },
          child: Text(
            S.of(context).skip_btn,
            style: TextStyle(
              color: Color(0xff999999),
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

