import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';
import 'package:varzish/widgets/background_theme.dart';
import 'package:varzish/widgets/loading.dart';
import 'package:varzish/widgets/logo.dart';

class BMI_Screen extends StatefulWidget {
  const BMI_Screen({super.key, required this.BMI});
  final double BMI;
  @override
  State<BMI_Screen> createState() => _BMI_ScreenState();
}

class _BMI_ScreenState extends State<BMI_Screen> {
  late double BMI;
  @override
  void initState() {
    super.initState();
    BMI = widget.BMI;
  }

  String BMIStatus() {
    if (BMI < 18.5) {
      return "Underweight";
    } else if (BMI >= 18.5 && BMI <= 24.9) {
      return "Healthy";
    } else if (BMI >= 25 && BMI <= 29.9) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  Color BMIColor() {
    if (BMI < 18.5) {
      return Colors.red;
    } else if (BMI >= 18.5 && BMI <= 24.9) {
      return Colors.green;
    } else if (BMI >= 25 && BMI <= 29.9) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  void _generatePlan() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Loading()));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTheme(
      child: Container(
        width: ScreenSize.width(context),
        height: ScreenSize.height(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Logo(),
            Stack(
              children: [
                SvgPicture.asset(
                  "assets/svg/BMI_scale.svg",
                  width: 150,
                  height: 140,
                ),
                Positioned.fill(
                  top: 0,
                  left: 0,
                  child: CustomPaint(
                    painter: BMIstick(bmi: BMI, context: context),
                    // child: Container(),
                  ),
                ),
              ],
            ),
            Text(
              "Your BMI is ${BMI.toStringAsFixed(2)} kgm-²",
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 2,
              color: AppColors.primary,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Status: ",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                    color: Colors.white),
              ),
              Text(
                BMIStatus(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: BMIColor(),
                ),
              ),
            ]),
            OutlinedButton(
              onPressed: _generatePlan,
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
              child: const Text(
                "Generate Plan",
                style: TextStyle(
                  color: Color.fromARGB(255, 86, 86, 86),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BMIstick extends CustomPainter {
  const BMIstick({required this.bmi, required this.context});
  final double bmi;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    double x = ScreenSize.width(context) / 2;
    double y = size.width / 2;
    int bmimover = 60;
    if (bmi < 18.5) {
      bmimover = -60;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      bmimover = -20;
    } else if (bmi >= 25 && bmi <= 29.9) {
      bmimover = 10;
    }
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width / 2 + bmimover, size.height / 2),
        Offset(size.width / 2, size.height - 10), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
