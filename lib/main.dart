import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varzish/local_storage/user_info.dart';
import 'package:varzish/models/userInfo.dart';
import 'package:varzish/providers/plan_stats_date_provider.dart';
import 'package:varzish/screens/BMI_screen.dart';
import 'package:varzish/screens/home/home_page.dart';
import 'package:varzish/screens/onboarding/onboarding.dart';
import 'package:varzish/screens/splash_screen.dart';
import 'package:varzish/utils/screenConstraints.dart';
import 'package:varzish/widgets/loading.dart';

void main() {
  runApp(
    ChangeNotifierProvider<PlanStatsDateProvider>(
      create: (_) => PlanStatsDateProvider(),
      child: MaterialApp(
        title: "Varzish",
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: const MyWidget(),
        routes: <String, WidgetBuilder>{
          '/onboarding': (BuildContext context) => new Onboarding(),
          '/loading': (BuildContext context) => new Loading(),
          '/home': (BuildContext context) => new HomePage(),
        },
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
  late Userinfo? userinfo;
  Future<void> getUser() async {
    Userinfo? user = await getUserInfo();
    setState(() {
      userinfo = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    splashController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));

    splashAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: splashController, curve: Curves.easeIn));

    onboardingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

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
              animation: splashAnimation,
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
                  child:
                      userinfo == null ? const Onboarding() : const HomePage(),
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