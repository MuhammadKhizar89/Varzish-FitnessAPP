import 'package:flutter/material.dart';
import 'package:varzish/utils/AppColors.dart';
import 'package:varzish/utils/screenConstraints.dart';

class Datecard extends StatefulWidget {
  const Datecard(
      {super.key,
      required this.date,
      required this.month,
      required this.isCompleted});
  final DateTime date;
  final int month;
  final bool isCompleted;
  @override
  State<Datecard> createState() => _DatecardState();
}

class _DatecardState extends State<Datecard> {
  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(20),
          color: widget.isCompleted ? Colors.black : Colors.white),
      width: ScreenSize.width(context) * 0.18,
      child: Column(
        children: [
          Container(
            height: 3,
            color: AppColors.primary,
          ),
          Text(
            widget.date.day.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 23,
                color: !widget.isCompleted ? Colors.black : Colors.white),
          ),
          Text(
            _getMonthName(widget.month),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 9,
                color: !widget.isCompleted ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }
}
