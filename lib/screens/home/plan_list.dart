import 'package:flutter/material.dart';
import 'package:varzish/screens/home/plan_card.dart';

class PlanList extends StatefulWidget {
  const PlanList({super.key});

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  // List of exercises with their properties
  final List<Map<String, dynamic>> exercises = [
    {
      "dayNo": 1,
      "completedPercentage": 100,
      "title": "Cardio",
      "description":
          "Cardio exercises improve heart health, burn calories, and boost endurance for overall fitness.",
      "calories": 560,
      "time": 20,
    },
    {
      "dayNo": 2,
      "completedPercentage": 0,
      "title": "Strength",
      "description":
          "Build muscle strength and endurance with resistance-based workouts.",
      "calories": 450,
      "time": 30,
    },
    {
      "dayNo": 3,
      "completedPercentage": 0,
      "title": "Yoga",
      "description":
          "Enhance flexibility, balance, and mindfulness with guided yoga poses.",
      "calories": 200,
      "time": 40,
    },
    {
      "dayNo": 4,
      "completedPercentage": 0,
      "title": "HIIT",
      "description":
          "High-intensity interval training for maximum calorie burn in short durations.",
      "calories": 600,
      "time": 15,
    },
    {
      "dayNo": 5,
      "completedPercentage": 0,
      "title": "Pilates",
      "description":
          "Strengthen core muscles and improve posture with controlled exercises.",
      "calories": 300,
      "time": 25,
    },
    {
      "dayNo": 6,
      "completedPercentage": 0,
      "title": "Stretching",
      "description":
          "Relieve muscle tension and improve flexibility through targeted stretches.",
      "calories": 150,
      "time": 10,
    },
    {
      "dayNo": 7,
      "completedPercentage": 0,
      "title": "Rest Day",
      "description": "Take a break and allow your muscles to recover.",
      "calories": 0,
      "time": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: exercises.map((exercise) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).push('/exercise');
            },
            child: PlanCard(
              dayNo: exercise["dayNo"],
              todayWorkoutDay: 02,
              completedPercentage: exercise["completedPercentage"],
              title: exercise["title"],
              description: exercise["description"],
              calories: exercise["calories"],
              time: exercise["time"],
            ),
          ),
        );
      }).toList(),
    );
  }
}
