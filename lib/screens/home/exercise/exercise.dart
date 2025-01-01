import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:varzish/models/exercise_data.dart';
import 'package:varzish/screens/home/exercise/exercise_info.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';

class Exercise extends StatefulWidget {
  const Exercise({
    super.key,
    required this.index,
    required this.exerciseData,
    required this.incrementIndex,
    required this.totalExercises,
    required this.decrementIndex,
    required this.isLoading,
  });

  final bool isLoading;
  final int totalExercises;
  final int index;
  final Function incrementIndex;
  final Function decrementIndex;
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Exercise Details",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                widget.exerciseData.name.toUpperCase().length > 38
                    ? widget.exerciseData.name.toUpperCase().substring(0, 25) +
                        "..."
                    : widget.exerciseData.name.toUpperCase(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              LinearPercentIndicator(
                backgroundColor: Colors.white,
                animation: true,
                lineHeight: 10,
                leading: Text(
                  "${widget.index + 1}/${widget.totalExercises}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Text(
                  "🗿",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                animationDuration: 2000,
                addAutomaticKeepAlive: true,
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
                child: ListView(
                  children: [
                    ExerciseInfo(
                      title: "🎯 Target: ",
                      description: widget.exerciseData.target,
                    ),
                    ExerciseInfo(
                      title: "🛠️ Equipment: ",
                      description: widget.exerciseData.equipment,
                    ),
                    ExerciseInfo(
                      title: "💪 Secondary Muscles: ",
                      description:
                          widget.exerciseData.secondaryMuscles[0] ?? '',
                    ),
                    ExerciseInfo(
                      title: "👉 Body Part: ",
                      description: widget.exerciseData.bodyPart,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Instructions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...widget.exerciseData.instructions.map(
                      (instruction) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "• ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 3, 3, 3),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                instruction,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(179, 31, 30, 30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      widget.decrementIndex();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.index == 0 ? "Quit" : "Back",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: widget.isLoading
                        ? null
                        : () {
                            widget.incrementIndex();
                          },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 35),
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
            ],
          ),
        ),
      ),
    );
  }
}
