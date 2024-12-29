import 'package:flutter/material.dart';
import 'package:varzish/utils/AppColors.dart';

class StatsCard extends StatelessWidget {
  const StatsCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.data,
      required this.iconColor});
  final IconData icon;
  final Color iconColor;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 223, 223),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Icon(
              icon,
              size: 100,
              color: iconColor,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(3, 3),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${title} :",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.black),
                ),
                Text(
                  "${data}",
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
