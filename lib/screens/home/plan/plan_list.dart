import 'package:flutter/material.dart';
import 'package:varzish/data/30_days_plan.dart';
import 'package:varzish/screens/home/exercise/exrcises_list.dart';
import 'package:varzish/screens/home/plan/plan_card.dart';

class PlanList extends StatefulWidget {
  const PlanList({super.key});
  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  final exercises = plan;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: exercises.map((exercise) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ExrcisesList(dayNo: exercise.dayNo);
                  },
                ),
              );
            },
            child: PlanCard(
              dayNo: exercise.dayNo,
              todayWorkoutDay: 02,
              completedPercentage: exercise.completedPercentage,
              title: exercise.title,
              description: exercise.description,
              calories: exercise.calories,
              time: exercise.time,
            ),
          ),
        );
      }).toList(),
    );
  }
}
