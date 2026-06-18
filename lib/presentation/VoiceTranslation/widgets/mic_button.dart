import 'package:flutter/material.dart';

class MicButton extends StatefulWidget {
  const MicButton({
    super.key,
    required this.isListening,
    required this.enabled,
    required this.onTap,
  });

  final bool isListening;
  final bool enabled;
  final VoidCallback onTap;

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton>
    with SingleTickerProviderStateMixin {
  static const _lavender = Color(0xffEAEAFA);
  static const _shadow = Color(0xffADADEB);
  static const _deep = Color(0xff5B5BD7);
  static const _accent = Color(0xff8484E1);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (widget.isListening) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant MicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening && !oldWidget.isListening) {
      _controller.repeat();
    } else if (!widget.isListening && oldWidget.isListening) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                if (widget.isListening) ...[
                  _ring(_controller.value),
                  _ring((_controller.value + 0.33) % 1.0),
                  _ring((_controller.value + 0.66) % 1.0),
                ],
                _innerCircle(),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Expanding concentric ring that fades as it grows.
  Widget _ring(double t) {
    final scale = 1.0 + t * 0.9;
    final opacity = (1.0 - t).clamp(0.0, 1.0) * 0.5;
    return IgnorePointer(
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _accent.withOpacity(opacity),
              width: 2.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _innerCircle() {
    final listening = widget.isListening;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      width: listening ? 132 : 128,
      height: listening ? 132 : 128,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: listening
              ? const [_accent, _deep]
              : widget.enabled
                  ? const [_shadow, _accent]
                  : [_lavender, _lavender.withOpacity(0.6)],
        ),
        boxShadow: [
          BoxShadow(
            color: (listening ? _deep : _shadow).withOpacity(
              listening ? 0.6 : 0.4,
            ),
            blurRadius: listening ? 28 : 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        listening ? Icons.mic : Icons.mic_none,
        color: Colors.white,
        size: 58,
      ),
    );
  }
}
