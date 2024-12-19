import 'package:flutter/material.dart';
import 'package:varzish/utils/AppColors.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Container(
          height: 2,
          width: 200,
          color: AppColors.primary,
        ),
      ],
    );
  }
}
