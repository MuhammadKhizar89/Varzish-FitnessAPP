import 'package:flutter/material.dart';
import 'package:varzish/screens/onboarding/height_screen.dart';
import 'package:varzish/screens/onboarding/plan_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() {
    return _OnboardingState();
  }
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: const BoxDecoration(
          // color: Colors.red,
          ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/logo.svg',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Your Personal Fitness Companion.",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 60),
            // child: PlanScreen(),
            child: HeightScreen(),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 125, 216, 13),
                  padding: const EdgeInsets.symmetric(horizontal: 30)),
              child: const Text(
                "Next",
                style: TextStyle(
                    color: Color.fromARGB(255, 86, 86, 86),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
