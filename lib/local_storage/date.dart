import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:varzish/models/date.dart';

const key = "date";

extension DateTimeComparison on DateTime {
  bool isSameDayAs(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

List<DateModel> generateMissingDates(List<DateModel> dateList) {
  DateTime lastdate = dateList[0].date;
  DateTime secondlastdate = dateList[1].date;
  Duration difference = lastdate.difference(secondlastdate);
  int gap = difference.inDays;
  print("${lastdate.day} ${secondlastdate.day}");
  print(gap);
  if (gap == 1) {
    return dateList;
  }

  for (int i = 1; i < gap; i++) {
    dateList.insert(
        i,
        DateModel(
            date: lastdate.subtract(Duration(days: i)), isCompleted: false));
  }
  return dateList;
}

Future<void> saveDateLocal(List<DateModel> dateList) async {
  final prefs = await SharedPreferences.getInstance();
  List<DateModel> updatedDateList = generateMissingDates(dateList);
  await prefs.setString(
      key, jsonEncode(updatedDateList.map((e) => e.toJson()).toList()));
}

Future<List<DateModel>> getDateLocal() async {
  final prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString(key);
  print(jsonString);
  if (jsonString != null) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => DateModel.fromJson(e)).toList();
  }
  DateTime now = DateTime.now();
  return List.generate(10, (index) {
    DateTime date = now.subtract(Duration(days: index));
    return DateModel(date: date, isCompleted: false);
  }).toList();
}
