import 'package:flutter/material.dart';
import 'package:varzish/models/userInfo.dart';
import 'package:varzish/screens/onboarding/age_screen.dart';
import 'package:varzish/screens/onboarding/height_screen.dart';
import 'package:varzish/screens/onboarding/plan_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varzish/screens/onboarding/weight_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:varzish/utils/AppColors.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() {
    return _OnboardingState();
  }
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  final Userinfo userinfo = new Userinfo();
  var pageIndex = 0;

  void setPlanState(String plan) {
    setState(() {
      userinfo.Plan = plan;
    });
  }

  void setAgeState(int year) {
    int age = DateTime.now().year - year;
    setState(() {
      userinfo.age = age;
    });
  }

  void setWeightState(int weight) {
    setState(() {
      userinfo.Weight = weight;
    });
  }

  void setHeightState(String height) {
    setState(() {
      userinfo.Height = height;
    });
  }

  @override
  void initState() {
    super.initState();
    userinfo.Plan = "Beginner";
    userinfo.Height = "3'0";
    userinfo.Weight = 50;
    userinfo.age = DateTime.now().year - 1960;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _moveToNextPage() {
    if (_pageController.hasClients) {
      final nextPage = (_pageController.page?.toInt() ?? 0) + 1;
      if (nextPage < 4) {
        setState(() {
          pageIndex = nextPage;
        });
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _moveToPreviousPage() {
    if (_pageController.hasClients) {
      final prevPage = (_pageController.page?.toInt() ?? 1) - 1;
      if (prevPage >= 0) {
        setState(() {
          pageIndex = prevPage;
        });
        _pageController.animateToPage(
          prevPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _finalizeData() {
    print(userinfo.Plan);
    print(userinfo.age);
    print(userinfo.Weight);
    print(userinfo.Height);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmoothPageIndicator(
            controller: _pageController,
            count: 4,
            effect: const ExpandingDotsEffect(
              dotWidth: 15,
              dotHeight: 4,
              activeDotColor: AppColors.primary,
              dotColor: AppColors.secondary,
            ),
            onDotClicked: (index) {},
          ),
          const SizedBox(
            height: 8,
          ),
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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  PlanScreen(
                    plan: userinfo.Plan,
                    setPlanState: setPlanState,
                  ),
                  HeightScreen(
                    height: userinfo.Height,
                    setHeightState: setHeightState,
                  ),
                  WeightScreen(
                    weight: userinfo.Weight,
                    setWeightState: setWeightState,
                  ),
                  AgeScreen(
                    age: userinfo.age,
                    setAgeState: setAgeState,
                  ),
                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            pageIndex == 0
                ? SizedBox.shrink()
                : OutlinedButton(
                    onPressed: _moveToPreviousPage,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      side: const BorderSide(color: Colors.white, width: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
            OutlinedButton(
              onPressed: (pageIndex == 3) ? _finalizeData : _moveToNextPage,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.primary,
                side: const BorderSide(width: 0),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: Text(
                (pageIndex == 3) ? "Finish" : "Next",
                style: const TextStyle(
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
