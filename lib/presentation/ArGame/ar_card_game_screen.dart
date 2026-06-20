import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/main.dart' show isArabic;

/// Launches the standalone Unity AR card-game app (a separate APK installed
/// on the device).
///
/// Self-contained on purpose — to drop this feature later: delete this file,
/// revert the "Game To Learn" card onTap in
/// [lib/presentation/LearningHome/learninghome.dart], remove the
/// `external_app_launcher` dependency, and the `<package>` query in
/// android/app/src/main/AndroidManifest.xml.
class ArCardGameScreen extends StatelessWidget {
  const ArCardGameScreen({super.key});

  /// applicationId of the standalone Unity AR game APK.
  static const String _gamePackage = 'com.DefaultCompany.TestARAR';

  Future<void> _launchGame(BuildContext context) async {
    final ar = isArabic();
    try {
      final installed = await LaunchApp.isAppInstalled(
        androidPackageName: _gamePackage,
      );
      if (!context.mounted) return;
      if (installed != true) {
        AppSnackBar.info(
          context,
          ar
              ? 'لعبة الكروت غير مثبّتة على الجهاز. ثبّتها أولًا.'
              : 'The card game is not installed. Please install it first.',
        );
        return;
      }
      await LaunchApp.openApp(
        androidPackageName: _gamePackage,
        openStore: false,
      );
    } catch (_) {
      if (!context.mounted) return;
      AppSnackBar.error(
        context,
        ar ? 'تعذّر فتح اللعبة.' : 'Could not open the game.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ar = isArabic();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(S.of(context).home1_service4, style: Textstyles.medium25),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.view_in_ar_rounded,
              size: 96,
              color: Color(0xff8484E1),
            ),
            const SizedBox(height: 24),
            Text(
              ar
                  ? 'تعلّم لغة الإشارة من خلال لعبة كروت بالواقع المعزّز.'
                  : 'Learn sign language through an AR card game.',
              textAlign: TextAlign.center,
              style: Textstyles.medium20,
            ),
            const SizedBox(height: 12),
            Text(
              ar
                  ? 'هتفتح اللعبة في تطبيق منفصل، وترجع هنا لما تخلّص.'
                  : 'The game opens in a separate app. Come back here when done.',
              textAlign: TextAlign.center,
              style: Textstyles.medium13.copyWith(
                color: const Color(0xff999999),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                txt: ar ? 'ابدأ اللعبة' : 'Start Game',
                onpressed: () => _launchGame(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
