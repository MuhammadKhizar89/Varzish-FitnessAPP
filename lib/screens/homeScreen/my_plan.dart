import 'package:flutter/material.dart';
import 'package:varzish/screens/homeScreen/date_list.dart';
import 'package:varzish/screens/homeScreen/plan_list.dart';

class MyPlan extends StatefulWidget {
  const MyPlan({super.key});

  @override
  State<MyPlan> createState() => _MyPlanState();
}

class _MyPlanState extends State<MyPlan> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          DateList(),
          PlanList(),
        ],
      ),
    );
  }
}
