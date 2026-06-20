import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/generated/l10n.dart';

class Noconnection extends StatelessWidget {
  const Noconnection({super.key, this.onRetry, this.isOverlay = false});

  /// Called when the user taps Retry. The screen will NOT auto-pop —
  /// it's the callback's responsibility to dismiss/replace.
  /// If null and not [isOverlay], Retry just pops back.
  /// If [isOverlay] is true, Retry is a no-op (connectivity stream restores
  /// the app automatically).
  final VoidCallback? onRetry;

  /// True when shown by [ConnectivityGate] as an app-wide overlay. Hides the
  /// back button (there's nowhere to back to) and disables the retry pop.
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: isOverlay
            ? null
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chevron_left),
              ),
        automaticallyImplyLeading: !isOverlay,
        elevation: 0,
        backgroundColor: const Color(0xffD6D6F5),
        foregroundColor: Colors.black,
        title: Text(
          S.of(context).no_connection,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 91),
          Image.asset(
            "Assets/images/noconnection.png",
            height: 150,
            width: 150,
          ),
          SizedBox(height: 30),
          Text(
            S.of(context).no_connection,
            style: Textstyles.medium25,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              S.of(context).no_connection_desc,
              style: const TextStyle(
                color: Color(0xff999999),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 36),
          if (!isOverlay)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Retrybutton(onRetry: onRetry),
            ),
        ],
      ),
    );
  }
}

class Retrybutton extends StatelessWidget {
  const Retrybutton({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff8484E1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (onRetry != null) {
            onRetry!();
          } else {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 32, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "Assets/images/retry.png",
                width: 22,
                height: 22,
              ),
              const SizedBox(width: 8),
              Text(
                S.of(context).retry,
                style: Textstyles.medium20.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
