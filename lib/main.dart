import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/onboarding/OnboardingScreen.dart';
import 'package:intl/intl.dart';
List<CameraDescription> cameras = [];
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  
  String? token = CacheHelper.getData("token");
  runApp(Signlingo(token: token,));
}

class Signlingo extends StatelessWidget {
  const Signlingo({super.key,required this.token});
final String? token;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.white,),scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home:token==null? Onboardingscreen():LearingHome(),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
