import 'dart:async';

import 'package:flutter/material.dart';

enum _AppSnackVariant { error, success, info }

/// App-wide top snackbar with gradient + glow. Backed by an [OverlayEntry]
/// instead of [ScaffoldMessenger] so we can animate from the top edge and
/// fully style the surface (gradient, glow, rounded corners, tap-to-dismiss).
class AppSnackBar {
  AppSnackBar._();

  static OverlayEntry? _currentEntry;
  static _AnimatedSnackBarState? _currentState;

  static void error(
    BuildContext context,
    String message, {
    VoidCallback? onRetry,
  }) {
    _show(
      context,
      message: message,
      variant: _AppSnackVariant.error,
      onRetry: onRetry,
    );
  }

  static void success(BuildContext context, String message) {
    _show(context, message: message, variant: _AppSnackVariant.success);
  }

  static void info(BuildContext context, String message) {
    _show(context, message: message, variant: _AppSnackVariant.info);
  }

  static void _show(
    BuildContext context, {
    required String message,
    required _AppSnackVariant variant,
    VoidCallback? onRetry,
  }) {
    _dismissCurrentImmediately();

    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _AnimatedSnackBar(
        message: message,
        config: _config(variant),
        onRetry: onRetry,
        onRequestRemove: () {
          if (_currentEntry == entry) {
            entry.remove();
            _currentEntry = null;
            _currentState = null;
          }
        },
        onStateCreated: (state) {
          if (_currentEntry == entry) _currentState = state;
        },
      ),
    );
    _currentEntry = entry;
    overlay.insert(entry);
  }

  /// Hard-removes any pending snackbar without playing the reverse animation.
  /// Used when a new snackbar replaces a previous one so there's no
  /// stacking / overlap during the swap.
  static void _dismissCurrentImmediately() {
    final entry = _currentEntry;
    if (entry == null) return;
    _currentState?.cancelAutoDismiss();
    entry.remove();
    _currentEntry = null;
    _currentState = null;
  }

  static _SnackConfig _config(_AppSnackVariant v) {
    // All variants share the CustomButton purple gradient (0xff8484E1).
    // Slight tonal gradient gives depth without breaking from the button
    // color the rest of the app uses.
    const gradientStart = Color(0xff9494E5);
    const gradientEnd = Color(0xff7373DC);
    const glow = Color(0xff8484E1);
    switch (v) {
      case _AppSnackVariant.error:
        return const _SnackConfig(
          gradientStart: gradientStart,
          gradientEnd: gradientEnd,
          glow: glow,
          icon: Icons.error_outline_rounded,
        );
      case _AppSnackVariant.success:
        return const _SnackConfig(
          gradientStart: gradientStart,
          gradientEnd: gradientEnd,
          glow: glow,
          icon: Icons.check_circle_outline_rounded,
        );
      case _AppSnackVariant.info:
        return const _SnackConfig(
          gradientStart: gradientStart,
          gradientEnd: gradientEnd,
          glow: glow,
          icon: Icons.info_outline_rounded,
        );
    }
  }
}

class _SnackConfig {
  const _SnackConfig({
    required this.gradientStart,
    required this.gradientEnd,
    required this.glow,
    required this.icon,
  });
  final Color gradientStart;
  final Color gradientEnd;
  final Color glow;
  final IconData icon;
}

class _AnimatedSnackBar extends StatefulWidget {
  const _AnimatedSnackBar({
    required this.message,
    required this.config,
    required this.onRequestRemove,
    required this.onStateCreated,
    this.onRetry,
  });

  final String message;
  final _SnackConfig config;
  final VoidCallback onRequestRemove;
  final ValueChanged<_AnimatedSnackBarState> onStateCreated;
  final VoidCallback? onRetry;

  @override
  State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _autoDismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
      reverseDuration: const Duration(milliseconds: 220),
    );
    widget.onStateCreated(this);
    _controller.forward();
    _autoDismissTimer = Timer(const Duration(seconds: 3), _dismiss);
  }

  void cancelAutoDismiss() {
    _autoDismissTimer?.cancel();
    _autoDismissTimer = null;
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    cancelAutoDismiss();
    await _controller.reverse();
    if (!mounted) return;
    widget.onRequestRemove();
  }

  @override
  void dispose() {
    cancelAutoDismiss();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, (1 - _controller.value) * -80),
                child: Opacity(
                  opacity: _controller.value.clamp(0.0, 1.0),
                  child: child,
                ),
              );
            },
            child: _SnackCard(
              message: widget.message,
              config: widget.config,
              onRetry: widget.onRetry,
              onClose: _dismiss,
            ),
          ),
        ),
      ),
    );
  }
}

class _SnackCard extends StatelessWidget {
  const _SnackCard({
    required this.message,
    required this.config,
    required this.onClose,
    this.onRetry,
  });

  final String message;
  final _SnackConfig config;
  final VoidCallback onClose;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [config.gradientStart, config.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: config.glow.withValues(alpha: 0.45),
            blurRadius: 28,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: config.glow.withValues(alpha: 0.2),
            blurRadius: 60,
            spreadRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClose,
          borderRadius: BorderRadius.circular(28),
          splashColor: Colors.white.withValues(alpha: 0.18),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Icon(config.icon, color: Colors.white, size: 15),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      onClose();
                      onRetry!();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
