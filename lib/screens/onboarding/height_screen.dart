import 'package:flutter/material.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';
import 'package:varzish/widgets/heading.dart';

class HeightScreen extends StatefulWidget {
  HeightScreen({
    super.key,
    required this.height,
    required this.setHeightState,
  });
  late final String height;
  final void Function(String height) setHeightState;
  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  List<String> _generateHeights() {
    List<String> heights = [];
    for (int ft = 3; ft <= 8; ft++) {
      for (int inch = 0; inch <= 11; inch++) {
        heights.add("$ft'${inch}");
      }
    }
    return heights;
  }

  final FixedExtentScrollController _controller = FixedExtentScrollController();
  @override
  Widget build(BuildContext context) {
    List<String> heights = _generateHeights();
    return Column(
      children: [
        const Heading(text: "Enter Your Height"),
        const SizedBox(height: 20),
        HeightWidget(
            height: widget.height,
            setHeightState: widget.setHeightState,
            heights: heights,
            controller: _controller)
      ],
    );
  }
}

class HeightWidget extends StatefulWidget {
  HeightWidget({
    super.key,
    required this.height,
    required this.heights,
    required this.controller,
    required this.setHeightState,
  });
  late final String height;
  final void Function(String height) setHeightState;
  final List<String> heights;
  late FixedExtentScrollController controller;

  @override
  State<HeightWidget> createState() => _HeightWidgetState();
}

class _HeightWidgetState extends State<HeightWidget> {
  @override
  void initState() {
    final int initialIndex = widget.heights.indexOf(widget.height);
    widget.controller = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            height: ScreenSize.height(context) * 0.50,
            child: CustomPaint(
              painter: LinePainter(),
              child: Stack(
                children: [
                  Positioned(
                    top: (ScreenSize.height(context) * 0.45) / 2,
                    right: 0,
                    child: const Text(
                      "My height is",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: SizedBox(
            height: ScreenSize.height(context) * 0.45,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: CustomPaint(
                    painter: HeightPainter(height: 0.4),
                  ),
                ),
                ListWheelScrollView.useDelegate(
                  controller: widget.controller,
                  diameterRatio: 100,
                  itemExtent: 50,
                  onSelectedItemChanged: (value) {
                    widget.setHeightState(widget.heights[value]);
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return AnimatedBuilder(
                        animation: widget.controller,
                        builder: (context, child) {
                          // print("Selected item: ${_controller.selectedItem}");
                          double selectedIndex =
                              widget.controller.selectedItem.toDouble();
                          double difference = (selectedIndex - index).abs();
                          double scale = 1 - (difference * 0.1).clamp(0.0, 0.5);
                          double offset = (difference * 20).clamp(0.0, 40);
                          // print(
                          // " index: ${index} Selected index: ${selectedIndex} difference: ${difference} scale: ${scale} offset: ${offset}");
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: offset),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(value, 0),
                                child: Transform.scale(
                                  scale: scale,
                                  child: Center(
                                    child: Text(
                                      widget.heights[index],
                                      style: TextStyle(
                                        color: index ==
                                                widget.controller.selectedItem
                                            ? AppColors.secondary
                                            : Colors.grey,
                                        fontSize: index ==
                                                widget.controller.selectedItem
                                            ? 20
                                            : 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    childCount: widget.heights.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HeightPainter extends CustomPainter {
  const HeightPainter({required this.height});
  final double height;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    double gap = size.height / 16;
    double centerY = size.height / 2;
    for (int i = 0; i < 17; i++) {
      double y = i * gap;
      double lineWidth = (y == centerY) ? size.width * 0.4 : size.width * 0.2;
      canvas.drawLine(
        Offset((size.width - lineWidth), y),
        Offset((size.width), y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary // Line color
      ..strokeWidth = 3.0 // Line thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final p = Paint()
      ..color = AppColors.primary // Line color
      ..strokeWidth = 2.0 // Line thickness
      ..style = PaintingStyle.stroke;

    // Drawing a line from the top-left to the bottom-right corner
    canvas.drawLine(
      Offset(0, 0), // Starting point (x, y)
      Offset(0, size.height), // Ending point (x, y)
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2), // Starting point (x, y)
      Offset(size.width, size.height / 2), // Ending point (x, y)
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
