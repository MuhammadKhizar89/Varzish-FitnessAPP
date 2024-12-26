import 'package:flutter/material.dart';
import 'package:varzish/screens/home/date_list.dart';
import 'package:varzish/utils/screenConstraints.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 255, 77),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Icon(
                  Icons.local_fire_department,
                  size: 100,
                  color: Colors.redAccent,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.red.withOpacity(0.5),
                      offset: Offset(0, 3),
                    ),
                  ],
                )),
                const Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Calories :",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                      ),
                      Text(
                        "500 kcal",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: const Color.fromARGB(255, 77, 255, 130),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Icon(
                  Icons.hourglass_empty,
                  size: 100,
                  color: Colors.blue,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.red.withOpacity(0.5),
                      offset: Offset(0, 3),
                    ),
                  ],
                )),
                const Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Hours :",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                      ),
                      Text(
                        "500 min",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          DateList(),
        ],
      ),
    );
  }
}
