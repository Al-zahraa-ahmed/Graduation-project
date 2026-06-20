import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/LearningHome/translationHome.dart';
import 'package:graduation_project/presentation/onboarding/OnboardingScreen.dart';

/// Animated splash screen with gradient background, pulsing glow behind the
/// hand, a continuous wave motion (fits the sign-language theme), and a
/// letter-by-letter reveal of the SignLingo wordmark. Once the sequence
/// finishes, it routes based on the cached token + mode.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const String _word = 'SignLingo';

  late final AnimationController _handEntrance;
  late final AnimationController _pulse;
  late final AnimationController _wave;
  late final AnimationController _textReveal;

  late final Animation<double> _handScale;
  late final Animation<double> _handOpacity;
  late final List<Animation<double>> _letterAnims;

  @override
  void initState() {
    super.initState();
    _handEntrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    // Pulse loops forever, reverses on each cycle for a "breathing" feel.
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    // Wave is started AFTER the entrance finishes (see _runSequence). While
    // value == 0 the rotation is 0, so the hand isn't wobbling during scale-in.
    _wave = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _textReveal = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _handScale = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _handEntrance, curve: Curves.easeOutBack),
    );
    _handOpacity = CurvedAnimation(
      parent: _handEntrance,
      curve: Curves.easeOut,
    );

    // Each letter gets its own Interval inside the shared _textReveal
    // controller — staggered so they fade in sequentially.
    const letterWindow = 0.4;
    final step = (1.0 - letterWindow) / (_word.length - 1);
    _letterAnims = List.generate(_word.length, (i) {
      final start = i * step;
      final end = (start + letterWindow).clamp(0.0, 1.0);
      return CurvedAnimation(
        parent: _textReveal,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });

    _runSequence();
  }

  Future<void> _runSequence() async {
    await _handEntrance.forward();
    _wave.repeat();
    await Future<void>.delayed(const Duration(milliseconds: 80));
    await _textReveal.forward();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    _goNext();
  }

  void _goNext() {
    final bool hasToken = CacheHelper.getData('token') != null;
    final String mode = CacheHelper.getData('mode') ?? 'l';
    final Widget next = !hasToken
        ? const Onboardingscreen()
        : mode == 'l'
            ? LearingHome()
            : Translationhome();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => next,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, anim, __, child) {
          final curved = CurvedAnimation(
            parent: anim,
            curve: Curves.easeOutCubic,
          );
          final scale = Tween<double>(begin: 1.08, end: 1.0).animate(curved);
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(scale: scale, child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _handEntrance.dispose();
    _pulse.dispose();
    _wave.dispose();
    _textReveal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffEAEAFA),
              Color(0xffF8F8FE),
              Color(0xffDDDDF3),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 340,
                  height: 340,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Pulsing glow circle — fades in with the hand, then
                      // breathes (scale + alpha) on a continuous loop.
                      AnimatedBuilder(
                        animation:
                            Listenable.merge([_pulse, _handEntrance]),
                        builder: (context, _) {
                          final p = _pulse.value;
                          final e = _handEntrance.value;
                          final scale = 0.95 + p * 0.18;
                          final alpha = ((0.45 - p * 0.25) * e)
                              .clamp(0.0, 1.0);
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 280,
                              height: 280,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    const Color(0xff8484E1)
                                        .withValues(alpha: alpha),
                                    const Color(0xff8484E1)
                                        .withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Hand: entrance scale + fade, then continuous gentle
                      // wave (rotation) — matches the sign-language theme.
                      AnimatedBuilder(
                        animation: Listenable.merge([_handEntrance, _wave]),
                        builder: (context, child) {
                          final rotation =
                              sin(_wave.value * 2 * pi) * 0.08;
                          return Opacity(
                            opacity:
                                _handOpacity.value.clamp(0.0, 1.0),
                            child: Transform.rotate(
                              angle: rotation,
                              child: Transform.scale(
                                scale: _handScale.value,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'Assets/images/signlingohand.png',
                          width: 260,
                          height: 260,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Letter-by-letter reveal: each glyph fades + slides up
                // on its own staggered interval within _textReveal.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_word.length, (i) {
                    return FadeTransition(
                      opacity: _letterAnims[i],
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.5),
                          end: Offset.zero,
                        ).animate(_letterAnims[i]),
                        child: Text(
                          _word[i],
                          style: const TextStyle(
                            color: Color(0xff2B3574),
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
