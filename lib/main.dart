import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/SignUp/SignUpScreen.dart';
import 'package:graduation_project/presentation/onboarding/OnboardingScreen.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const GraduationProject());
}

class GraduationProject extends StatelessWidget {
  const GraduationProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Onboardingscreen(),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
