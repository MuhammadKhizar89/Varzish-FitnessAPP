import 'package:flutter/material.dart';
import 'package:varzish/utils/screenConstraints.dart';

class HeightScreen extends StatefulWidget {
  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: ScreenSize.height(context) * 0.45,
            child: CustomPaint(
              painter: LinePainter(),
              child: Stack(
                children: [
                  Positioned(
                    top: (ScreenSize.height(context) * 0.40) / 2,
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
          child: Container(
            height: ScreenSize.height(context) * 0.45,
            decoration: const BoxDecoration(color: Colors.yellow),
            child: const Text("Height"),
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
      ..strokeWidth = 2.0 // Line thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final p = Paint()
      ..color = Color.fromARGB(255, 125, 216, 13) // Line color
      ..strokeWidth = 4.0 // Line thickness
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
