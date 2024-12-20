import 'package:flutter/material.dart';
import 'package:varzish/screens/onboarding/onboarding.dart';
import 'package:varzish/screens/splash_screen.dart';
import 'package:varzish/utils/screenConstraints.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Varzish",
      theme: ThemeData(
        fontFamily: 'Poppins', // Default font family
      ),
      home: Scaffold(
        body: MyWidget(),
      ),
    ),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  bool splash = true;
  late Animation<double> splashAnimation, onboardingAnimation;
  late AnimationController splashController, onboardingController;
  @override
  void initState() {
    super.initState();

    splashController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));

    splashAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: splashController, curve: Curves.easeIn));

    onboardingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    onboardingAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: onboardingController, curve: Curves.easeIn));

    splashController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          splash = false;
        });
        onboardingController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.height(context),
      width: ScreenSize.width(context),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/_backgroundImage.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: splash
          ? AnimatedBuilder(
              animation: splashController,
              builder: (context, child) {
                print(splashController.value);
                return Opacity(
                  opacity: splashAnimation.value,
                  child: SplashScreen(
                    splash: (showOnboarding) {
                      setState(() {
                        if (!showOnboarding) {
                          splashController.forward();
                        }
                      });
                    },
                  ),
                );
              },
            )
          : AnimatedBuilder(
              animation: onboardingController,
              builder: (context, child) {
                return Opacity(
                  opacity: onboardingAnimation.value,
                  child: const Onboarding(),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    splashController.dispose();
    onboardingController.dispose();
    super.dispose();
  }
}

// Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //         colors: [Colors.black, Colors.green],
        //         stops: [0.20, 1]),
        //   ),
        // ),
        // Container(
        //   decoration: const BoxDecoration(
        //     gradient: RadialGradient(
        //       center: Alignment.center,
        //       radius: 0.5,
        //       colors: [Colors.transparent, Colors.black45],
        //     ),
        //   ),
        // ),