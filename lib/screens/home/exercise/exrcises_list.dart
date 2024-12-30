import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:varzish/models/exercise_data.dart';
import 'package:varzish/screens/home/exercise/exercise.dart';
import 'package:http/http.dart' as http;

class ExrcisesList extends StatefulWidget {
  const ExrcisesList({super.key, required this.dayNo});
  final int dayNo;
  @override
  State<ExrcisesList> createState() => _ExrcisesListState();
}

class _ExrcisesListState extends State<ExrcisesList> {
  int index = 0;
  late List<ExerciseData> exercises = [];

  Future<void> fetchExercises() async {
    final url =
        'https://exercisedb.p.rapidapi.com/exercises?limit=10&offset=${widget.dayNo + 10}';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-key': 'f976efe201msh14d2053bedc2696p1631a9jsncc1c5a0e0398',
        'x-rapidapi-host': 'exercisedb.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
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
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
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
