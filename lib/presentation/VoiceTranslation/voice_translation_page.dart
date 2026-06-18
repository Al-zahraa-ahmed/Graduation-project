import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/VoiceTranslation/voice_translation_cubit.dart';
import 'package:graduation_project/presentation/VoiceTranslation/widgets/mic_button.dart';
import 'package:graduation_project/presentation/VoiceTranslation/widgets/transcript_card.dart';

class VoiceTranslationPage extends StatelessWidget {
  const VoiceTranslationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VoiceTranslationCubit()..initialize(),
      child: const _VoiceTranslationView(),
    );
  }
}

class _VoiceTranslationView extends StatelessWidget {
  const _VoiceTranslationView();

  static const _lavender = Color(0xffEAEAFA);
  static const _shadow = Color(0xffADADEB);
  static const _muted = Color(0xff999999);

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final t = _Strings(isAr: isAr);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(t.title, style: Textstyles.medium20),
        centerTitle: true,
      ),
      body: BlocConsumer<VoiceTranslationCubit, VoiceTranslationState>(
        listenWhen: (prev, curr) => curr is VoiceTranslationFailure,
        listener: (context, state) {
          if (state is VoiceTranslationFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(_errorText(state, t)),
                  backgroundColor: Colors.red.shade400,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 3),
                ),
              );
          }
        },
        builder: (context, state) {
          final isListening = state is VoiceTranslationListening;
          final isInitializing = state is VoiceTranslationInitializing;
          final unavailable = state is VoiceTranslationFailure &&
              state.type == VoiceErrorType.unavailable;
          final displayText = _displayText(state);
          final hasText = displayText.trim().isNotEmpty;

          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  _StatusBanner(
                    state: state,
                    t: t,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TranscriptCard(
                      text: displayText,
                      placeholder: t.placeholder,
                      isListening: isListening,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: hasText
                        ? _ActionRow(
                            key: const ValueKey('actions'),
                            text: displayText,
                            t: t,
                          )
                        : const SizedBox(
                            key: ValueKey('empty'), height: 40),
                  ),
                  const SizedBox(height: 12),
                  MicButton(
                    isListening: isListening,
                    enabled: !isInitializing && !unavailable,
                    onTap: () => _onMicTap(context, isListening),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isListening
                        ? t.tapToStop
                        : unavailable
                            ? t.errUnavailable
                            : t.tapToSpeak,
                    style: TextStyle(
                      color: unavailable ? Colors.red : _muted,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onMicTap(BuildContext context, bool isListening) {
    HapticFeedback.lightImpact();
    final cubit = context.read<VoiceTranslationCubit>();
    if (isListening) {
      cubit.stopListening();
    } else {
      cubit.startListening();
    }
  }

  String _displayText(VoiceTranslationState state) {
    if (state is VoiceTranslationReady) return state.text;
    if (state is VoiceTranslationListening) return state.displayText;
    return '';
  }

  String _errorText(VoiceTranslationFailure f, _Strings t) {
    switch (f.type) {
      case VoiceErrorType.permissionDenied:
        return t.errPermission;
      case VoiceErrorType.unavailable:
        return t.errUnavailable;
      case VoiceErrorType.noSpeech:
        return t.errNoSpeech;
      case VoiceErrorType.unknown:
        return t.errGeneric;
    }
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({
    required this.state,
    required this.t,
    required this.isAr,
  });

  final VoiceTranslationState state;
  final _Strings t;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final info = _resolve();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _VoiceTranslationView._lavender,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _VoiceTranslationView._shadow.withValues(alpha: 0.55),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(info.icon, color: info.color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              info.text,
              style: Textstyles.medium16.copyWith(color: Colors.black87),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _VoiceTranslationView._shadow.withValues(alpha: 0.7),
              ),
            ),
            child: Text(
              // Speech recognition is Arabic-only regardless of UI language.
              t.langArShort,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff5C5CB0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ({String text, Color color, IconData icon}) _resolve() {
    if (state is VoiceTranslationInitializing) {
      return (
        text: t.initializing,
        color: const Color(0xff7B7BD0),
        icon: Icons.hourglass_top_rounded,
      );
    }
    if (state is VoiceTranslationListening) {
      return (
        text: t.listening,
        color: Colors.red.shade400,
        icon: Icons.graphic_eq_rounded,
      );
    }
    if (state is VoiceTranslationFailure) {
      return (
        text: t.errorTitle,
        color: Colors.red.shade400,
        icon: Icons.error_outline_rounded,
      );
    }
    return (
      text: t.readyHint,
      color: const Color(0xff7B7BD0),
      icon: Icons.mic_none_rounded,
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({super.key, required this.text, required this.t});

  final String text;
  final _Strings t;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionChip(
          icon: Icons.copy_rounded,
          label: t.copy,
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: text));
            if (!context.mounted) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(t.copied),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 1),
                ),
              );
          },
        ),
        const SizedBox(width: 12),
        _ActionChip(
          icon: Icons.delete_outline_rounded,
          label: t.clear,
          onTap: () => context.read<VoiceTranslationCubit>().clear(),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: _VoiceTranslationView._lavender,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _VoiceTranslationView._shadow.withValues(alpha: 0.8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: const Color(0xff5C5CB0)),
              const SizedBox(width: 6),
              Text(label, style: Textstyles.medium13),
            ],
          ),
        ),
      ),
    );
  }
}

class _Strings {
  const _Strings({required this.isAr});
  final bool isAr;

  String get title => isAr ? 'الترجمة الصوتية' : 'Voice Translation';
  String get tapToSpeak => isAr ? 'اضغط للتحدث' : 'Tap the mic to speak';
  String get tapToStop => isAr ? 'اضغط للإيقاف' : 'Tap to stop';
  String get listening => isAr ? 'جارٍ الاستماع...' : 'Listening...';
  String get initializing => isAr ? 'جارٍ التهيئة...' : 'Initializing...';
  String get readyHint => isAr ? 'جاهز للاستماع' : 'Ready to listen';
  String get placeholder => isAr
      ? 'سيظهر النص المُحوَّل من صوتك هنا'
      : 'Your transcribed speech will appear here';
  String get copy => isAr ? 'نسخ' : 'Copy';
  String get clear => isAr ? 'مسح' : 'Clear';
  String get copied => isAr ? 'تم النسخ' : 'Copied to clipboard';
  String get langArShort => 'AR';
  String get langEnShort => 'EN';

  String get errorTitle => isAr ? 'حدث خطأ' : 'Something went wrong';
  String get errPermission => isAr
      ? 'تم رفض إذن الميكروفون. يرجى السماح من الإعدادات.'
      : 'Microphone permission denied. Please allow it in settings.';
  String get errUnavailable => isAr
      ? 'التعرف على الكلام غير متاح على هذا الجهاز'
      : 'Speech recognition is not available on this device';
  String get errNoSpeech => isAr
      ? 'لم نسمع شيئاً. حاول مرة أخرى'
      : "We didn't catch that. Please try again";
  String get errGeneric =>
      isAr ? 'حدث خطأ. حاول مرة أخرى' : 'An error occurred. Please try again';
}
