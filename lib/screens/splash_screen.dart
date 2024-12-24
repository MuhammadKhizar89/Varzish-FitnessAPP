import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:varzish/widgets/background_theme.dart';
import 'package:varzish/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    super.key,
    required this.splash,
  });
  late ValueChanged splash;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      widget.splash(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTheme(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(),
            const SizedBox(
              height: 7,
            ),
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
