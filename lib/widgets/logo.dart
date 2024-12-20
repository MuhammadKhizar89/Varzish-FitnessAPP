import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}
