import 'package:flutter/material.dart';
import 'package:varzish/utils/screenConstraints.dart';

class HeightScreen extends StatefulWidget {
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

  int _selectedIndex = 0;
  final FixedExtentScrollController _controller = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    List<String> heights = _generateHeights();
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
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
                  controller: _controller,
                  diameterRatio: 100,
                  itemExtent: 50,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    print("Selected index: $index");
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          print("Selected item: ${_controller.selectedItem}");
                          print("Selected index: ${index}");
                          double selectedIndex =
                              _controller.selectedItem.toDouble();
                          double difference = (selectedIndex - index).abs();
                          double scale = 1 - (difference * 0.1).clamp(0.0, 0.3);
                          double offset = (difference * 20).clamp(0.0, 40);
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: offset),
                            duration: Duration(
                                milliseconds:
                                    300), // Smooth transition duration
                            curve: Curves
                                .easeInOut, // Easing curve for smooth effect
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(value, 0),
                                child: Transform.scale(
                                  scale: scale,
                                  child: Center(
                                    child: Text(
                                      heights[index], // Dynamic data
                                      style: TextStyle(
                                        color: index == _controller.selectedItem
                                            ? Color.fromARGB(255, 125, 216, 13)
                                            : Colors.grey,
                                        fontSize:
                                            index == _controller.selectedItem
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
                    childCount: heights.length,
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
      ..color = Color.fromARGB(255, 125, 216, 13) // Line color
      ..strokeWidth = 2.0 // Line thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final p = Paint()
      ..color = Color.fromARGB(255, 125, 216, 13) // Line color
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

// how can i do that lines generated should be in height
// and all will be space evenly according to geight but the center one will be more large in width then others
// void paint(Canvas canvas, Size size) {
//     print(size);
//     final p = Paint()
//       ..color = Color.fromARGB(255, 125, 216, 13) // Line color
//       ..strokeWidth = 4.0 // Line thickness
//       ..style = PaintingStyle.stroke;

//     double gap = size.height / 7;
//     double current = height;
//     print(gap);
//     for (int i = 0; i < gap; i++) {
//       canvas.drawLine(
//         Offset(0, current), // Starting point (x, y)
//         Offset(size.width, current), // Ending point (x, y)
//         p,
//       );
//       current += gap;
//     }
//   }
