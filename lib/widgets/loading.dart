import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varzish/screens/home/home_page.dart';
import 'package:varzish/screens/onboarding/onboarding.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/app_constants.dart';
import 'package:varzish/utils/screenConstraints.dart';
import 'package:varzish/widgets/background_theme.dart';
import 'package:varzish/widgets/logo.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationController ac;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 2 * 3.1415)
        .animate(CurvedAnimation(parent: ac, curve: Curves.linear));
    ac.repeat();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTheme(
        child: Container(
      width: ScreenSize.width(context),
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Logo(),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: animation.value,
                    child: SvgPicture.asset(
                      'assets/svg/loading.svg',
                      width: 100,
                      height: 100,
                    ),
                  );
                },
              ),
              const Text(
                "Your plan is being generated......",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    ));
  }
}
