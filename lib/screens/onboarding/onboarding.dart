import 'package:flutter/material.dart';
import 'package:varzish/models/userInfo.dart';
import 'package:varzish/screens/BMI_screen.dart';
import 'package:varzish/screens/onboarding/age_screen.dart';
import 'package:varzish/screens/onboarding/height_screen.dart';
import 'package:varzish/screens/onboarding/plan_screen.dart';
import 'package:varzish/screens/onboarding/weight_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/widgets/background_theme.dart';
import 'package:varzish/widgets/loading.dart';
import 'package:varzish/widgets/logo.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() {
    return _OnboardingState();
  }
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  final Userinfo userinfo = Userinfo();
  var pageIndex = 0;
  bool disableButton = false;
  bool isLoading = false;
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

  void _moveToNextPage() async {
    setState(() {
      disableButton = true;
    });
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
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() {
        disableButton = false;
      });
    }
  }

  void _moveToPreviousPage() async {
    setState(() {
      disableButton = true;
    });

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
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() {
        disableButton = false;
      });
    }
  }

  void _finalizeData() async {
    setState(() {
      isLoading = true;
      disableButton = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    List<String> heightParts = userinfo.Height.split("'");
    int feet = int.parse(heightParts[0]);
    int inches = heightParts.length > 1 ? int.parse(heightParts[1]) : 0;
    int totalInches = (feet * 12) + inches;
    double heightInMeters = totalInches * 0.0254;
    double bmi = userinfo.Weight / (heightInMeters * heightInMeters);
    setState(() {
      isLoading = false;
      disableButton = false;
    });
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => BMI_Screen(
          BMI: bmi,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTheme(
      child: Container(
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
            Logo(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pageIndex == 0
                    ? const SizedBox.shrink()
                    : OutlinedButton(
                        onPressed: !disableButton ? _moveToPreviousPage : null,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          side:
                              const BorderSide(color: Colors.white, width: 0.5),
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
                  onPressed: !disableButton
                      ? (pageIndex == 3)
                          ? _finalizeData
                          : _moveToNextPage
                      : null,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    side: const BorderSide(width: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return const Color.fromARGB(164, 125, 216, 13);
                        }
                        return AppColors.primary;
                      },
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 86, 86, 86),
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          (pageIndex == 3) ? "Finish" : "Next",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 86, 86, 86),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
