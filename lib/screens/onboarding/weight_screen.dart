import 'package:flutter/material.dart';
import 'package:varzish/utils/screenConstraints.dart';
import 'package:varzish/widgets/heading.dart';

class WeightScreen extends StatefulWidget {
  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
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
                  // color: Colors.red,
                  width: ScreenSize.width(context), // Explicitly set width here
                  child: CustomPaint(
                    painter: LinePainter(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: ScreenSize.width(context), // Explicitly set width here
                  child: CustomPaint(
                    painter: WeightPainter(),
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
      ..color = Color.fromARGB(255, 125, 216, 13) // Line color
      ..strokeWidth = 1.0 // Line thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final p = Paint()
      ..color = Color.fromARGB(255, 125, 216, 13) // Line color
      ..strokeWidth = 1.0 // Line thickness
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, 0), // Starting point (x, y)
      Offset(size.width, 0), // Ending point (x, y)
      paint,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0), // Starting point (x, y)
      Offset(size.width / 2, size.height), // Ending point (x, y)
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
