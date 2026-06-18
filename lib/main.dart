import 'package:camera/camera.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/ConnectivityGate.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/data/Services/sign_language_classifier.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';
import 'package:graduation_project/presentation/onboarding/OnboardingScreen.dart';
import 'package:intl/intl.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  // Initialize sign language model (loads ONNX in background, doesn't block UI)
  SignLanguageClassifier.instance.initialize();

  String? token = CacheHelper.getData("token");
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => BlocProvider(
        create: (context) {
          final cubit = ProfileCubit();
          // Only fetch profile if user is authenticated. Avoids a guaranteed
          // 401 storm on fresh installs / logged-out launches.
          if (token != null) cubit.getMainData();
          return cubit;
        },
        child: Signlingo(token: token),
      ),
    ),
  );
}

class Signlingo extends StatelessWidget {
  const Signlingo({super.key, required this.token});
  final String? token;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String currentLang = CacheHelper.getData('lang') ?? 'en';
        String currentmode = CacheHelper.getData('mode') ?? 'l';

        // Both ProfileSucces and ProfilePrefUpdateFailed carry a user object.
        // Prefer the cubit's user over the cache so the app reflects the
        // canonical (or rolled-back) value the moment the cubit decides.
        if (state is ProfileSucces) {
          currentLang = state.user.language ?? currentLang;
          currentmode = state.user.mode ?? currentmode;
        } else if (state is ProfilePrefUpdateFailed) {
          currentLang = state.user.language ?? currentLang;
          currentmode = state.user.mode ?? currentmode;
        }

        S.load(Locale(currentLang));
        return MaterialApp(
          key: ValueKey(currentLang),
          // Compose DevicePreview's builder with the connectivity gate so the
          // NoConnection overlay sits above the navigator app-wide.
          builder: (context, child) => ConnectivityGate(
            child: DevicePreview.appBuilder(context, child),
          ),
          theme: ThemeData(
            fontFamily: 'Roboto',
            fontFamilyFallback: const ['Cairo'],
            appBarTheme: AppBarTheme(backgroundColor: Colors.white),
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          locale: Locale(currentLang),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: token == null
              ? Onboardingscreen()
              : currentmode == 'l'
                  ? LearingHome()
                  : Translationhome(),
        );
      },
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
