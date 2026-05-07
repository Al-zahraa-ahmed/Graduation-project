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
  static const _shadow = Color(0xffADADEB);
  static const _muted = Color(0xff999999);

  @override
  Widget build(BuildContext context) {
    final isEmpty = text.trim().isEmpty;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _lavender,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _shadow.withValues(alpha: 0.55),
            offset: const Offset(2, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: isEmpty
          ? _EmptyState(placeholder: placeholder)
          : SingleChildScrollView(
              reverse: true,
              child: SelectableText(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  height: 1.45,
                  color: Colors.black87,
                ),
              ),
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.placeholder});
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.record_voice_over_outlined,
            size: 56,
            color: TranscriptCard._shadow,
          ),
          const SizedBox(height: 12),
          Text(
            placeholder,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: TranscriptCard._muted,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
