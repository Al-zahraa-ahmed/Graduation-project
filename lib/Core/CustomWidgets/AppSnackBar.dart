import 'package:flutter/material.dart';

enum _AppSnackVariant { error, success, info }

class AppSnackBar {
  AppSnackBar._();

  static const Color _primary = Color(0xff1E1E7B);
  static const Color _buttonColor = Color(0xff8484E1);

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
    final messenger = ScaffoldMessenger.of(context);
    // clearSnackBars() drains the entire queue immediately — no animation race
    // when a new error replaces a stale one.
    messenger.clearSnackBars();

    final config = _config(variant);

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(config.icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: config.background,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        dismissDirection: DismissDirection.down,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: config.accent, width: 1.5),
        ),
        elevation: 6,
        action: onRetry != null
            ? SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }

  static _SnackConfig _config(_AppSnackVariant v) {
    switch (v) {
      case _AppSnackVariant.error:
        return const _SnackConfig(
          background: _buttonColor,
          accent: Color(0xffE57373),
          icon: Icons.error_outline,
        );
      case _AppSnackVariant.success:
        return const _SnackConfig(
          background: _buttonColor,
          accent: Color(0xff81C784),
          icon: Icons.check_circle_outline,
        );
      case _AppSnackVariant.info:
        return const _SnackConfig(
          background: _buttonColor,
          accent: _primary,
          icon: Icons.info_outline,
        );
    }
  }
}

class _SnackConfig {
  const _SnackConfig({
    required this.background,
    required this.accent,
    required this.icon,
  });
  final Color background;
  final Color accent;
  final IconData icon;
}
