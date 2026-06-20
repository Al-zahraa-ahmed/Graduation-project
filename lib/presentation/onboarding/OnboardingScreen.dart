import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Appmodes/ChooseAppMode.dart';
import 'package:graduation_project/presentation/onboarding/Widgets/Screen.dart';

/// Slide-from-right + fade. Used for onboarding step → step and the final
/// step → OnboardingMode so each transition has the same feel.
PageRoute<T> _slideForwardRoute<T>(Widget next) {
  return PageRouteBuilder<T>(
    pageBuilder: (_, __, ___) => next,
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (_, anim, __, child) {
      final slide = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
      return SlideTransition(
        position: slide,
        child: FadeTransition(opacity: anim, child: child),
      );
    },
  );
}

/// Single-page onboarding step. The previous version used a PageView with
/// the four screens inlined — now each step is its own route, navigated
/// to via [Navigator.pushReplacement] so the back stack stays clean.
class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key, this.index = 0});

  /// 0-based step index. Defaults to 0 so the existing
  /// `Onboardingscreen()` callsites (main.dart) still work unchanged.
  final int index;

  static const _totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    // Order matches the original PageView order so step copy and assets
    // line up with what was shipped before.
    final pages = <({String img, String title, String desc})>[
      (
        img: 'Assets/images/Women engaged in a conversation or discussion.png',
        title: l.screen1_title,
        desc: l.screen1_desc,
      ),
      (
        img: 'Assets/images/Chatbot high-fives and answers the question.png',
        title: l.screen2_title,
        desc: l.screen2_desc,
      ),
      (
        img: 'Assets/images/Voice assistant answering questions@4x.png',
        title: l.screen3_title,
        desc: l.screen3_desc,
      ),
      (
        img:
            'Assets/images/Playing adventure game in virtual reality, Digital gaming experience in VR.png',
        title: l.screen4_title,
        desc: l.screen4_desc,
      ),
    ];

    final current = pages[index.clamp(0, pages.length - 1)];
    final isLast = index >= pages.length - 1;

    return Scaffold(
      body: Container(
        // Expand to fill the full body — otherwise the gradient shrinks to
        // the SingleChildScrollView's content height and the unfilled area
        // shows the Scaffold's default white background.
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffEAEAFA), Color(0xffD6D6F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Image + skip + texts grow to fill all space above the
              // bottom controls. The image inside screen1 is wrapped in
              // its own Expanded so it shrinks on small screens — no
              // overflow risk.
              Expanded(
                child: screen1(
                  img: current.img,
                  txt1: current.title,
                  txt2: current.desc,
                ),
              ),
              DotsIndicator(
                dotsCount: _totalSteps,
                position: index.toDouble(),
                decorator: const DotsDecorator(),
              ),
              const SizedBox(height: 20),
              CustomButton(
                txt: l.onboarding_btn,
                onpressed: () {
                  final next = isLast
                      ? const OnboardingMode()
                      : Onboardingscreen(index: index + 1);
                  Navigator.pushReplacement(
                    context,
                    _slideForwardRoute(next),
                  );
                },
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
