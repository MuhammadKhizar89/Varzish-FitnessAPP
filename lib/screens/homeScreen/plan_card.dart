import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            widget.todayWorkoutDay != widget.dayNo ? Colors.grey : Colors.black,
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                progressColor: AppColors.secondary,
              ),
              Text(
                "0${widget.dayNo}",
                style: const TextStyle(
                    color: Colors.white,
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
                      style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: AppColors.secondary,
                          size: 15,
                        ),
                        Text(
                          "${widget.calories.toString()}kcal",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.hourglass_empty,
                          color: AppColors.secondary,
                          size: 12,
                        ),
                        Text(
                          "${widget.time} min",
                          style: TextStyle(
                              color: Colors.white,
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
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(50),
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
