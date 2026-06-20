import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/CustomWidgets/ConnectivityGate.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/data/Services/sign_language_classifier.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Splash/SplashScreen.dart';
import 'package:intl/intl.dart';

List<CameraDescription> cameras = [];

/// App-wide navigator key so non-UI code (e.g. the Dio 401 interceptor) can
/// navigate without a BuildContext.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  // Initialize sign language model (loads ONNX in background, doesn't block UI)
  SignLanguageClassifier.instance.initialize();

  final String? token = CacheHelper.getData("token");
  runApp(
    BlocProvider(
      create: (context) {
        final cubit = ProfileCubit();
        // Only fetch profile if user is authenticated. Avoids a guaranteed
        // 401 storm on fresh installs / logged-out launches.
        if (token != null) cubit.getMainData();
        return cubit;
      },
      child: const Signlingo(),
    ),
  );
}

class Signlingo extends StatelessWidget {
  const Signlingo({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // Cache is the source of truth for the active locale. Cubit writes
        // the cache BEFORE emitting on changelang, so any rebuild triggered
        // by an emit reads the updated value here. Token/mode are read inside
        // SplashScreen when deciding the next route.
        final String currentLang = CacheHelper.getData('lang') ?? 'en';

        S.load(Locale(currentLang));
        return MaterialApp(
          key: ValueKey(currentLang),
          navigatorKey: navigatorKey,
          // Connectivity gate sits above the navigator app-wide so the
          // NoConnection overlay can mount over any screen.
          builder: (context, child) => ConnectivityGate(child: child!),
          theme: ThemeData(
            fontFamily: 'Roboto',
            fontFamilyFallback: const ['Cairo'],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
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
          home: const SplashScreen(),
        );
      },
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
