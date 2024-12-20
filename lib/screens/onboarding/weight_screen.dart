import 'package:flutter/material.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';
import 'package:varzish/widgets/heading.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({
    super.key,
    required this.weight,
    required this.setWeightState,
  });
  final int weight;
  final void Function(int weight) setWeightState;
  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final List<int> weightList = List.generate(101, (index) => index + 50);
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    final int initialIndex = weightList.indexOf(widget.weight);
    _controller = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Heading(text: "Enter your Weight"),
        const SizedBox(height: 20),
        Container(
          width:
              ScreenSize.width(context), // Setting width based on screen size
          height: ScreenSize.height(context) * 0.50, // Set a fixed height
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: ScreenSize.width(context), // Explicitly set width here
                  child: CustomPaint(
                    painter: LinePainter(),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: ScreenSize.width(context) * 0.34 - 30,
                          // left: ScreenSize.height(context) * 0.40,
                          child: const Text(
                            "My weight is",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: ScreenSize.width(context),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: WeightPainter(),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) {
                            widget.setWeightState(weightList[value]);
                          },
                          itemExtent: 65,
                          physics: const FixedExtentScrollPhysics(),
                          diameterRatio: 100,
                          controller: _controller,
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 100,
                            builder: (context, index) {
                              return AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  double selectedIndex =
                                      _controller.selectedItem.toDouble();
                                  double difference =
                                      (selectedIndex - index).abs();
                                  double offset =
                                      (difference * 20).clamp(0.0, 20);
                                  if (offset == 0) {
                                    offset = -70;
                                  }
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: offset),
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    builder: (context, value, child) {
                                      double scale =
                                          index == _controller.selectedItem
                                              ? 2.5
                                              : 0.8;
                                      return Transform.translate(
                                        offset: Offset(-value, 15),
                                        child: Transform.scale(
                                          scale: scale,
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child: Text(
                                              index == _controller.selectedItem
                                                  ? weightList[index]
                                                          .toString() +
                                                      " kg"
                                                  : weightList[index]
                                                      .toString(),
                                              style: TextStyle(
                                                color: index ==
                                                        _controller.selectedItem
                                                    ? AppColors.secondary
                                                    : Colors.grey,
                                                fontSize: index ==
                                                        _controller.selectedItem
                                                    ? 20
                                                    : 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary // Line color
      ..strokeWidth = 2.0 // Line thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final p = Paint()
      ..color = AppColors.primary // Line color
      ..strokeWidth = 2.0 // Line thickness
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, 0), // Starting point (x, y)
      Offset(size.width, 0), // Ending point (x, y)
      paint,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0), // Starting point (x, y)
      Offset(size.width / 2, size.height - 20), // Ending point (x, y)
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WeightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    double gap = size.width / 16;
    double centerX = size.width / 2;
    for (int i = 0; i < 17; i++) {
      double x = i * gap;
      double lineWidth = (x == centerX) ? size.width * 0.4 : size.width * 0.2;
      canvas.drawLine(
        Offset(x, (size.height - lineWidth)),
        Offset(x, (size.height)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
