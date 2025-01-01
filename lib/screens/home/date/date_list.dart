import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varzish/providers/plan_stats_date_provider.dart';
import 'package:varzish/screens/home/date/date_card.dart';
import 'package:varzish/utils/screenConstraints.dart';

class DateList extends StatefulWidget {
  const DateList({super.key});

  @override
  State<DateList> createState() => _DateListState();
}

class _DateListState extends State<DateList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanStatsDateProvider>(context);
    final dateList = provider.dateList;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: ScreenSize.height(context) * 0.10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateList.length,
        itemBuilder: (context, index) {
          final dateInfo = dateList[index];
          return Datecard(
            date: dateList[index].date,
            month: dateList[index].date.month,
            isCompleted: dateList[index].isCompleted,
          );
        },
      ),
    );
  }
}
