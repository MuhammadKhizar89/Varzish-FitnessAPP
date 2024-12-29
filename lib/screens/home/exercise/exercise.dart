import 'package:flutter/material.dart';
import 'package:varzish/apis/giphy.dart';
import 'package:varzish/models/exercise_data.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';

class Exercise extends StatefulWidget {
  const Exercise(
      {super.key, required this.exerciseData, required this.incrementIndex});
  final Function incrementIndex;
  final ExerciseData exerciseData;
  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.exerciseData.name}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: ScreenSize.height(context) * 0.60,
              child: widget.exerciseData.gifUrl != null
                  ? Image.network(widget.exerciseData.gifUrl!,
                      fit: BoxFit.cover)
                  : const CircularProgressIndicator(),
            ),
            Text(
              "${widget.exerciseData.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "${widget.exerciseData.target}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            OutlinedButton(
              onPressed: () {
                widget.incrementIndex();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
