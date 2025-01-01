import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varzish/data/30_days_plan.dart';
import 'package:varzish/models/plan.dart';
import 'package:varzish/providers/plan_stats_date_provider.dart';
import 'package:varzish/screens/home/exercise/exrcises_list.dart';
import 'package:varzish/screens/home/plan/plan_card.dart';

class PlanList extends StatefulWidget {
  const PlanList({super.key});
  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  @override
  Future<void> _initializePlanList(BuildContext context) async {
    final provider = Provider.of<PlanStatsDateProvider>(context, listen: false);
    await provider.initPlanList();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initializePlanList(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final provider = Provider.of<PlanStatsDateProvider>(context);
          final exercises = provider.planList;
          print(exercises);
          final todayWorkoutDay = provider.todaysPlanDay;
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
                    todayWorkoutDay: todayWorkoutDay,
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
        });
  }
}
