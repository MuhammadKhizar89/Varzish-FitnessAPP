import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:varzish/screens/home/exercise/exrcises_list.dart';
import 'package:varzish/utils/AppColors.dart';

class PlanCard extends StatefulWidget {
  PlanCard(
      {super.key,
      required this.dayNo,
      required this.completedPercentage,
      required this.title,
      required this.description,
      required this.calories,
      required this.time,
      required this.todayWorkoutDay});
  final int dayNo;
  final int completedPercentage;
  final String title;
  final String description;
  final int calories;
  final int time;
  final int todayWorkoutDay;
  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
        color: widget.todayWorkoutDay != widget.dayNo
            ? const Color.fromARGB(255, 223, 223, 223)
            : Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularPercentIndicator(
                radius: 20,
                animation: true,
                animationDuration: 1200,
                lineWidth: 3.0,
                percent: widget.completedPercentage / 100,
                center: Text(
                  "${widget.completedPercentage.toString()}%",
                  style: TextStyle(
                      color: widget.todayWorkoutDay == widget.dayNo
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                progressColor: widget.todayWorkoutDay == widget.dayNo
                    ? AppColors.secondary
                    : Colors.black,
              ),
              Text(
                widget.dayNo < 10 ? "0${widget.dayNo}" : "${widget.dayNo}",
                style: TextStyle(
                    color: widget.todayWorkoutDay == widget.dayNo
                        ? AppColors.secondary
                        : Colors.black,
                    fontSize: 33,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: widget.todayWorkoutDay == widget.dayNo
                              ? AppColors.secondary
                              : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                          color: widget.todayWorkoutDay == widget.dayNo
                              ? Colors.white
                              : Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: widget.todayWorkoutDay == widget.dayNo
                              ? AppColors.secondary
                              : Colors.black,
                          size: 15,
                        ),
                        Text(
                          "${widget.calories.toString()}kcal",
                          style: TextStyle(
                              color: widget.todayWorkoutDay == widget.dayNo
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.hourglass_empty,
                          color: widget.todayWorkoutDay == widget.dayNo
                              ? AppColors.secondary
                              : Colors.black,
                          size: 12,
                        ),
                        Text(
                          "${widget.time} min",
                          style: TextStyle(
                              color: widget.todayWorkoutDay == widget.dayNo
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ExrcisesList(dayNo: widget.dayNo);
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black, width: 0.6),
                  ),
                  child: Icon(
                    widget.completedPercentage == 100
                        ? Icons.done
                        : Icons.play_arrow_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
