import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_connective.dart';

enum InternetState {
  connected,
  disconnected,
}

final internetStatusProvider =
StateNotifierProvider<InternetStatusNotifier, InternetState>(
      (ref) => InternetStatusNotifier(),
);

class InternetStatusNotifier extends StateNotifier<InternetState> {
  InternetStatusNotifier() : super(InternetState.connected) {
    _startMonitoring();
  }

  Timer? _timer;

  void _startMonitoring() {
    _check();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
          (_) => _check(),
    );
  }

  Future<void> _check() async {
    final hasInternet = await AppConnectivity.connectivity();
    state = hasInternet
        ? InternetState.connected
        : InternetState.disconnected;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
