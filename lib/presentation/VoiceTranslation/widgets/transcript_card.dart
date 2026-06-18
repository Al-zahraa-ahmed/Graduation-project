import 'package:flutter/material.dart';

class TranscriptCard extends StatelessWidget {
  const TranscriptCard({
    super.key,
    required this.text,
    required this.placeholder,
    required this.isListening,
  });

  final String text;
  final String placeholder;
  final bool isListening;

  static const _lavender = Color(0xffEAEAFA);
  static const _lavenderDeep = Color(0xffD6D6F5);
  static const _shadow = Color(0xffADADEB);
  static const _muted = Color(0xff999999);
  static const _purple = Color(0xff5B5BD7);

  @override
  Widget build(BuildContext context) {
    final isEmpty = text.trim().isEmpty;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_lavender, _lavenderDeep],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: _shadow.withOpacity(0.45),
            offset: const Offset(2, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: isEmpty
          ? _EmptyState(placeholder: placeholder, isListening: isListening)
          : _TranscriptText(text: text, isListening: isListening),
    );
  }
}

class _TranscriptText extends StatelessWidget {
  const _TranscriptText({required this.text, required this.isListening});
  final String text;
  final bool isListening;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: text,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (isListening) const _BlinkingCursor(),
        ],
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _c,
      child: Container(
        width: 3,
        height: 26,
        margin: const EdgeInsetsDirectional.only(start: 4, bottom: 2),
        decoration: BoxDecoration(
          color: TranscriptCard._purple,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.placeholder, required this.isListening});
  final String placeholder;
  final bool isListening;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(isListening ? 0.85 : 0.55),
              boxShadow: isListening
                  ? [
                      BoxShadow(
                        color: TranscriptCard._purple.withOpacity(0.25),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              isListening
                  ? Icons.graphic_eq_rounded
                  : Icons.record_voice_over_outlined,
              size: 36,
              color: isListening
                  ? TranscriptCard._purple
                  : TranscriptCard._shadow,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            placeholder,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: TranscriptCard._muted,
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
