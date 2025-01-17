import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:varzish/providers/plan_stats_date_provider.dart';
import 'package:varzish/screens/home/stats/stats_card.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanStatsDateProvider>(context);
    final calories = provider.totalCalories;
    final time = provider.totalTime;
    final completeion = provider.planCompletion;
    return Center(
      child: Column(
        children: [
          const Text("Plan Completion",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
          const SizedBox(height: 10),
          LinearPercentIndicator(
            backgroundColor: Colors.grey,
            width: ScreenSize.width(context) * 0.9,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: completeion,
            center: Text(
              "${(completeion * 100).toStringAsFixed(2)}%",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            barRadius: const Radius.circular(10),
            progressColor: AppColors.primary,
          ),
          const SizedBox(
            height: 20,
          ),
          StatsCard(
            title: "Total Calories",
            icon: Icons.local_fire_department_sharp,
            iconColor: Colors.redAccent,
            data: "${calories} kcal",
          ),
          SizedBox(
            height: 20,
          ),
          StatsCard(
            title: "Total Hours",
            icon: Icons.hourglass_empty,
            iconColor: Colors.blueAccent,
            data: "${time} Mins",
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Colors.black,
                    Color.fromARGB(180, 0, 0, 0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.01, 0.50, 1]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Developed By :",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  "Muhammad Khizar",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
