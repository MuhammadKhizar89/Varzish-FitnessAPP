import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varzish/apis/exercise_db_api.dart';
import 'package:varzish/models/exercise_data.dart';
import 'package:varzish/screens/home/exercise/exercise.dart';

class ExrcisesList extends StatefulWidget {
  const ExrcisesList({super.key, required this.dayNo});
  final int dayNo;
  @override
  State<ExrcisesList> createState() => _ExrcisesListState();
}

class _ExrcisesListState extends State<ExrcisesList> {
  int index = 0;
  late List<ExerciseData> exercises = [];

  void fetchExercises() async {
    var data = await fetchExercisesAPI(widget.dayNo);
    print(data);
    if (data == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Error'),
            content: const Text('Cannot fetch data from Server'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      for (var value in data) {
        exercises.add(
          ExerciseData(
            bodyPart: value['bodyPart'] ?? '',
            equipment: value['equipment'] ?? '',
            gifUrl: value['gifUrl'] ?? '',
            id: value['id'] ?? '',
            name: value['name'] ?? '',
            target: value['target'] ?? '',
            secondaryMuscles:
                List<String>.from(value['secondaryMuscles'] ?? []),
            instructions: List<String>.from(value['instructions'] ?? []),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  void incrementIndex() {
    if (index == exercises.length - 1) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      index += 1;
    });
  }

  void decrementIndex() {
    if (index == 0) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      index -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: exercises.isEmpty
            ? const CircularProgressIndicator()
            : Exercise(
                decrementIndex: decrementIndex,
                totalExercises: exercises.length,
                index: index,
                incrementIndex: incrementIndex,
                exerciseData: exercises[index],
              ),
      ),
    );
  }
}
