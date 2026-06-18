import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/ErrorsScreens/NoConnection.dart';

/// App-wide network gate. Subscribes to [Connectivity.onConnectivityChanged]
/// and overlays the [Noconnection] screen whenever the device reports no
/// active network. Auto-dismisses as soon as a connection returns.
///
/// Note: this checks for the presence of a network interface (WiFi/cellular),
/// NOT real internet reachability. Captive portals or DNS failures will still
/// look "online" — per-API errors should still be handled in their own cubits.
class ConnectivityGate extends StatefulWidget {
  const ConnectivityGate({super.key, required this.child});
  final Widget child;

  @override
  State<ConnectivityGate> createState() => _ConnectivityGateState();
}

class _ConnectivityGateState extends State<ConnectivityGate> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _sub;
  bool? _isOnline; // null = still checking initial state

  @override
  void initState() {
    super.initState();
    _checkInitial();
    _sub = _connectivity.onConnectivityChanged.listen(_onChange);
  }

  Future<void> _checkInitial() async {
    final results = await _connectivity.checkConnectivity();
    if (!mounted) return;
    _onChange(results);
  }

  void _onChange(List<ConnectivityResult> results) {
    final online = results.any((r) => r != ConnectivityResult.none);
    if (online == _isOnline) return;
    setState(() => _isOnline = online);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // While we don't yet know, show the child — pretend optimistic. Avoids a
    // brief NoConnection flash on cold start before the first check resolves.
    if (_isOnline == false) {
      // Overlay the NoConnection screen on top of the existing app so when
      // the connection comes back we don't lose the user's navigation stack.
      return Stack(
        children: [
          widget.child,
          const Positioned.fill(child: Noconnection(isOverlay: true)),
        ],
      );
    }
    return widget.child;
  }
}
