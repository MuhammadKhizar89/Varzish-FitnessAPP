import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:varzish/apis/giphy.dart';
import 'package:varzish/models/exercise_data.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';

class Exercise extends StatefulWidget {
  const Exercise(
      {super.key,
      required this.index,
      required this.exerciseData,
      required this.incrementIndex,
      required this.totalExercises});

  final int totalExercises;
  final int index;
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
        title: Text(
          "${widget.exerciseData.name.toUpperCase()}",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            LinearPercentIndicator(
              backgroundColor: Colors.white,
              animation: true,
              lineHeight: 10,
              animationDuration: 2000,
              percent: (widget.index) / 10,
              progressBorderColor: Colors.black,
              animateFromLastPercent: true,
              center: Text(
                "${((widget.index) * 10).toString()}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7),
              ),
              barRadius: Radius.circular(10),
              progressColor: AppColors.primary,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2),
              ),
              width: double.infinity,
              height: ScreenSize.height(context) * 0.40,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: widget.exerciseData.gifUrl != null
                  ? Image.network(widget.exerciseData.gifUrl!,
                      fit: BoxFit.cover)
                  : const CircularProgressIndicator(),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        const Text(
                          "🎯 Target: ",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.exerciseData.target[0].toUpperCase()}${widget.exerciseData.target.substring(1)}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(children: [
                      const Text(
                        "🛠️ Equipment: ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${widget.exerciseData.equipment[0].toUpperCase()}${widget.exerciseData.equipment.substring(1)}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ]),
                  ),
                  const Text(
                    "Instructions",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.exerciseData.instructions.length,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "• ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Expanded(
                              child: Text(
                                widget.exerciseData.instructions[index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.index + 1 == widget.totalExercises
                        ? "Finish"
                        : "Next",
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
