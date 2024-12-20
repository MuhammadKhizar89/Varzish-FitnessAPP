import 'package:flutter/material.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';

class PlanScreen extends StatefulWidget {
  PlanScreen({
    super.key,
    required this.plan,
    required this.setPlanState,
  });
  late final String plan;
  final void Function(String plan) setPlanState;
  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  void setButtonState(String state) {
    setState(() {
      widget.setPlanState(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Select your Plan level ",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        SizedBox(
          height: ScreenSize.height(context) * 0.35,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  title: "Beginner",
                  isClicked: this.widget.plan == "Beginner",
                  setButtonState: setButtonState,
                ),
                CustomButton(
                  title: "Intermediate",
                  isClicked: this.widget.plan == "Intermediate",
                  setButtonState: setButtonState,
                ),
                CustomButton(
                  title: "Advanced",
                  isClicked: this.widget.plan == "Advanced",
                  setButtonState: setButtonState,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.isClicked,
      required this.setButtonState});
  final bool isClicked;
  final Function setButtonState;
  final String title;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      child: OutlinedButton(
        onPressed: () {
          widget.setButtonState(widget.title);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              widget.isClicked ? AppColors.primary : Colors.transparent,
          side: const BorderSide(
              color: Color.fromARGB(158, 73, 121, 15), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 21,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
