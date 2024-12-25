import 'package:flutter/material.dart';
import 'package:varzish/screens/homeScreen/date_card.dart';
import 'package:varzish/utils/screenConstraints.dart';

class DateList extends StatefulWidget {
  const DateList({super.key});

  @override
  State<DateList> createState() => _DateListState();
}

class _DateListState extends State<DateList> {
  // Generate a list of the past 10 dates, including today
  List<Map<String, dynamic>> generateDates() {
    DateTime now = DateTime.now();
    return List.generate(10, (index) {
      DateTime date = now.subtract(Duration(days: index));
      return {
        "date": date,
        "month": _getMonthName(date.month),
        "isCompleted": index % 3 == 1
      };
    }).reversed.toList();
  }

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
    final dates = generateDates();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: ScreenSize.height(context) * 0.10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final dateInfo = dates[index];
          return Datecard(
            date: dateInfo["date"],
            month: dateInfo["month"],
            isCompleted: dateInfo["isCompleted"],
          );
        },
      ),
    );
  }
}
