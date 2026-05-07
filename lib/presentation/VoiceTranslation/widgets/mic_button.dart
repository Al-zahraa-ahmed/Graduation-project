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
  static const _deep = Color(0xff7B7BD0);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
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
      width: 170,
      height: 170,
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                if (widget.isListening) ...[
                  _pulse(_controller.value),
                  _pulse((_controller.value + 0.5) % 1.0),
                ],
                _innerCircle(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _pulse(double t) {
    final scale = 1.0 + t * 0.7;
    final opacity = (1.0 - t).clamp(0.0, 1.0) * 0.45;
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _shadow.withValues(alpha: opacity),
        ),
      ),
    );
  }

  Widget _innerCircle() {
    final listening = widget.isListening;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: listening
              ? const [_shadow, _deep]
              : widget.enabled
                  ? const [_lavender, _shadow]
                  : [_lavender, _lavender.withValues(alpha: 0.6)],
        ),
        boxShadow: [
          BoxShadow(
            color: _shadow.withValues(alpha: listening ? 0.7 : 0.45),
            blurRadius: listening ? 22 : 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(
        listening ? Icons.mic : Icons.mic_none,
        color: Colors.white,
        size: 54,
      ),
    );
  }
}
