import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        goPage();
      }
    });
  }

  void goPage() {
    if (!mounted) return;
    // Всегда перенаправляем на главную страницу, без обязательной регистрации

    Future.delayed(const Duration(seconds: 1), () async {
      if (Platform.isIOS) {
        HapticFeedback.mediumImpact();
      } else if (Platform.isAndroid) {
        if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 30);
      }
      }
      //Vibration.vibrate(preset: VibrationPreset.singleShortBuzz);
      AppNavigator.pushAndPopUntil(const MainRoute());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/thousand_melochey_splash.json',
          controller: _controller,
          onLoaded: (composition) {
            // указываем длительность
            _controller.duration = composition.duration;
            // запускаем вручную
            _controller.forward(from: 0);
          },
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
